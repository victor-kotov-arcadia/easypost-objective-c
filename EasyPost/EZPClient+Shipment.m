//
//  EZPClient+Shipment.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+Shipment.h"
#import "EZPClient+Synchronous.h"
#import "EZPRate.h"

@implementation EZPClient (Shipment)

- (void)listShipments:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager GET:@"shipments"
                  parameters:parameters
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPShipment success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPShipmentList *)listOfShipmentsWithParameters:(NSDictionary *)parameters
{
    EZPShipmentList *shipmentList = [self GET:@"shipments"
                                   parameters:parameters
                                responseClass:[EZPShipmentList class]];
    shipmentList.filters = [parameters mutableCopy];
    return shipmentList;
}

- (void)retrieveShipment:(NSString *)itemId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"shipments/%@", itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPShipment success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPShipment *)retrieveShipment:(NSString *)itemId
{
    NSParameterAssert(itemId);
    return [self GET:[NSString stringWithFormat:@"shipments/%@", itemId]
          parameters:nil responseClass:[EZPShipment class]];
}

- (void)createShipmentWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"shipments"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPShipment success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPShipment *)createShipmentWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"shipments" parameters:parameters responseClass:[EZPShipment class]];
}

- (void)createShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion
{
    if (shipment.itemId) {
        [NSException raise:NSInternalInconsistencyException format:@"Resource Already Created"];
    }

    NSDictionary *parameters = [shipment toDictionaryWithPrefix:@"shipment"];
    [self createShipmentWithParameters:parameters completion:^(EZPShipment *serverShipment, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
            NSAssert(false, nil);
        }
        [shipment mergeWithObject:serverShipment];

        completion(error);
    }];
}

- (void)createShipmentSynchronously:(EZPShipment *)shipment
{
    if (shipment.itemId) {
        [NSException raise:NSInternalInconsistencyException format:@"Resource Already Created"];
    }
    NSDictionary *parameters = [shipment toDictionaryWithPrefix:@"shipment"];
    EZPShipment *response = [self createShipmentWithParameters:parameters];
    [shipment mergeWithObject:response];
}

- (void)fetchRatesForShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion
{
    if (shipment.itemId) {
        [self _fetchRatesForShipment:shipment completion:^(NSError *error) {
            if (error) {
                completion(error);
            } else {
                completion(nil);
            }
        }];

        return;
    }

    [self createShipment:shipment completion:^(NSError *error) {
        if (error) {
            completion(error);
        }
        [self _fetchRatesForShipment:shipment completion:^(NSError *error) {
            if (error) {
                completion(error);
            } else {
                completion(nil);
            }
        }];
    }];
}

- (void)fetchRatesForShipmentSynchronously:(EZPShipment *)shipment
{
    if (!shipment.itemId) {
        [self createShipmentSynchronously:shipment];
    }

    EZPShipment *response = [self GET:[NSString stringWithFormat:@"shipments/%@/rates", shipment.itemId]
                           parameters:nil responseClass:[EZPShipment class]];
    [shipment mergeWithObject:response];
}

- (void)_fetchRatesForShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion
{
    NSAssert(shipment.itemId, @"shipment.itemId == nil");
    [self.sessionManager GET:[NSString stringWithFormat:@"shipments/%@", shipment.itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPShipment success:responseObject completion:^(EZPShipment *serverShipment, NSError *error) {
                             if (error) {
                                 NSLog(@"Error userInfo: %@", [error userInfo]);
                                 NSAssert(false, [error localizedDescription]);
                             }
                             [shipment mergeWithObject:serverShipment];
                             completion(nil);
                         }];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(error);
                     }];
}

- (void)buyShipment:(EZPShipment *)shipment withRate:(EZPRate *)rate completion:(void(^)(NSError *error))completion
{
    NSParameterAssert(shipment.itemId);
    NSParameterAssert(rate);
    [self.sessionManager POST:[NSString stringWithFormat:@"shipments/%@/buy", shipment.itemId]
                   parameters:@{@"rate": @{@"id": rate.itemId}}
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPShipment success:responseObject completion:^(EZPShipment *serverShipment, NSError *error) {
                              if (error) {
                                  NSLog(@"Error userInfo: %@", [error userInfo]);
                                  NSAssert(false, [error localizedDescription]);
                              }
                              [shipment mergeWithObject:serverShipment];
                              completion(nil);
                          }];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(error);
                      }];
}

- (void)buyShipmentSynchronously:(EZPShipment *)shipment withRate:(EZPRate *)rate
{
    NSParameterAssert(shipment.itemId);
    NSParameterAssert(rate);
    EZPShipment *response = [self POST:[NSString stringWithFormat:@"shipments/%@/buy", shipment.itemId]
                            parameters:@{@"rate": @{@"id": rate.itemId}}
                         responseClass:[EZPShipment class]];
    [shipment mergeWithObject:response];
}

- (void)insureShipment:(EZPShipment *)shipment forAmount:(double)amount completion:(void(^)(NSError *error))completion
{
    NSParameterAssert(shipment.itemId);
    [self.sessionManager POST:[NSString stringWithFormat:@"shipments/%@/insure", shipment.itemId]
                   parameters:@{@"amount": [NSString stringWithFormat:@"%f", amount]}
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPShipment success:responseObject completion:^(EZPShipment *serverShipment, NSError *error) {
                              if (error) {
                                  NSLog(@"Error userInfo: %@", [error userInfo]);
                                  NSAssert(false, [error localizedDescription]);
                              }
                              [shipment mergeWithObject:serverShipment];
                              completion(nil);
                          }];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(error);
                      }];
}

- (void)insureShipmentSynchronously:(EZPShipment *)shipment forAmount:(double)amount
{
    NSParameterAssert(shipment.itemId);
    EZPShipment *response = [self POST:[NSString stringWithFormat:@"shipments/%@/insure", shipment.itemId]
                            parameters:@{@"amount": [NSString stringWithFormat:@"%f", amount]} responseClass:[EZPShipment class]];
    [shipment mergeWithObject:response];
}

- (void)refundShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion
{
    NSParameterAssert(shipment.itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"shipments/%@/refund", shipment.itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPShipment success:responseObject completion:^(EZPShipment *serverShipment, NSError *error) {
                             if (error) {
                                 NSLog(@"Error userInfo: %@", [error userInfo]);
                                 NSAssert(false, [error localizedDescription]);
                             }
                             [shipment mergeWithObject:serverShipment];
                             completion(nil);
                         }];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(error);
                     }];
}

- (void)refundShipmentSynchronously:(EZPShipment *)shipment
{
    NSParameterAssert(shipment.itemId);
    EZPShipment *response = [self GET:[NSString stringWithFormat:@"shipments/%@/refund", shipment.itemId]
                           parameters:nil responseClass:[EZPShipment class]];
    [shipment mergeWithObject:response];
}

- (void)generateLabel:(NSString *)fileFormat forShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion
{
    NSAssert(shipment.itemId, @"shipment.itemId == nil");
    [self.sessionManager GET:[NSString stringWithFormat:@"shipments/%@/label", shipment.itemId]
                  parameters:@{@"file_format": fileFormat}
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPShipment success:responseObject completion:^(EZPShipment *serveShipment, NSError *error) {
                             if (error) {
                                 NSLog(@"Error userInfo: %@", [error userInfo]);
                                 NSAssert(false, [error localizedDescription]);
                             }
                             [shipment mergeWithObject:serveShipment];
                             completion(nil);
                         }];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(error);
                     }];
}

- (void)generateLabelSynchronously:(NSString *)fileFormat forShipment:(EZPShipment *)shipment
{
    NSParameterAssert(fileFormat);
    NSParameterAssert(shipment.itemId);
    EZPShipment *response = [self GET:[NSString stringWithFormat:@"shipments/%@/label", shipment.itemId]
                           parameters:@{@"file_format": fileFormat} responseClass:[EZPShipment class]];
    [shipment mergeWithObject:response];
}

- (void)generateStampForShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion
{
    NSAssert(shipment.itemId, @"shipment.itemId == nil");
    [self.sessionManager GET:[NSString stringWithFormat:@"shipments/%@/stamp", shipment.itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPShipment success:responseObject completion:^(EZPShipment *serverShipment, NSError *error) {
                             if (error) {
                                 NSLog(@"Error userInfo: %@", [error userInfo]);
                                 NSAssert(false, [error localizedDescription]);
                             }
                             [shipment mergeWithObject:serverShipment];
                             completion(nil);
                         }];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(error);
                     }];
}

- (void)generateStampForShipmentSynchronously:(EZPShipment *)shipment
{
    NSParameterAssert(shipment.itemId);
    EZPShipment *response = [self GET:[NSString stringWithFormat:@"shipments/%@/stamp", shipment.itemId]
                           parameters:nil responseClass:[EZPShipment class]];
    [shipment mergeWithObject:response];
}

- (void)generateBarcodeForShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion
{
    NSAssert(shipment.itemId, @"shipment.itemId == nil");
    [self.sessionManager GET:[NSString stringWithFormat:@"shipments/%@/barcode", shipment.itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPShipment success:responseObject completion:^(EZPShipment *serverShipment, NSError *error) {
                             if (error) {
                                 NSLog(@"Error userInfo: %@", [error userInfo]);
                                 NSAssert(false, [error localizedDescription]);
                             }
                             [shipment mergeWithObject:serverShipment];
                             completion(nil);
                         }];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(error);
                     }];
}

- (void)generateBarcodeForShipmentSynchronously:(EZPShipment *)shipment
{
    NSParameterAssert(shipment.itemId);
    EZPShipment *response = [self GET:[NSString stringWithFormat:@"shipments/%@/barcode", shipment.itemId]
                           parameters:nil responseClass:[EZPShipment class]];
    [shipment mergeWithObject:response];
}

- (void)lowestRateForShipment:(EZPShipment *)shipment includeCarriers:(NSArray *)includeCarriers includeServices:(NSArray *)includeServices excludeCarriers:(NSArray *)excludeCarriers excludeServices:(NSArray *)excludeServices completion:(void(^)(EZPRate *lowestRate))completion
{
    if (shipment.rates) {
        EZPRate *lowestRate = [shipment _lowestRateFromRates:shipment.rates includeCarriers:includeCarriers includeServices:includeServices excludeCarriers:excludeCarriers excludeServices:excludeServices];
        completion(lowestRate);
        return;
    }

    [self fetchRatesForShipment:shipment completion:^(NSError *error) {
        EZPRate *lowestRate = [shipment _lowestRateFromRates:shipment.rates includeCarriers:includeCarriers includeServices:includeServices excludeCarriers:excludeCarriers excludeServices:excludeServices];
        completion(lowestRate);
    }];
}

- (EZPRate *)lowestRateForShipmentSynchronously:(EZPShipment *)shipment includeCarriers:(NSArray *)includeCarriers includeServices:(NSArray *)includeServices excludeCarriers:(NSArray *)excludeCarriers excludeServices:(NSArray *)excludeServices
{
    if (!shipment.rates) {
        [self fetchRatesForShipmentSynchronously:shipment];
    }

    return [shipment _lowestRateFromRates:shipment.rates includeCarriers:includeCarriers includeServices:includeServices excludeCarriers:excludeCarriers excludeServices:excludeServices];
}

- (EZPRate *)lowestRateForShipment:(EZPShipment *)shipment
{
    return [self lowestRateForShipmentSynchronously:shipment includeCarriers:nil includeServices:nil excludeCarriers:nil excludeServices:nil];
}
@end
