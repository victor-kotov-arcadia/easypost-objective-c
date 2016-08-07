//
//  EZPClient+Batch.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Synchronous.h"
#import "EZPClient+Private.h"
#import "EZPClient+Batch.h"

@implementation EZPClient (Batch)

- (void)retrieveBatch:(NSString *)itemId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"batches/%@", itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPBatch success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPBatch *)retrieveBatch:(NSString *)batchId
{
    NSParameterAssert(batchId);
    return [self GET:[NSString stringWithFormat:@"batches/%@", batchId]
          parameters:nil responseClass:[EZPBatch class]];
}

- (void)createBatchWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"batches"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPBatch success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPBatch *)createBatchWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"batches" parameters:parameters responseClass:[EZPBatch class]];
}

- (void)addShipmentsWithShipments:(NSArray *)shipments toBatch:(EZPBatch *)batch completion:(void(^)(NSError *error))completion
{
    [self addShipments:[batch shipmentIdsWithShipments:shipments] toBatch:batch completion:completion];
}

- (void)addShipmentsWithShipmentsSynchronously:(NSArray *)shipments toBatch:(EZPBatch *)batch
{

}

- (void)addShipments:(NSArray *)shipmentIds toBatch:(EZPBatch *)batch completion:(void(^)(NSError *error))completion
{
    NSAssert(batch.itemId, @"batch.itemId == nil");
    [self.sessionManager POST:[NSString stringWithFormat:@"batches/%@/add_shipments", batch.itemId]
                   parameters:[batch parametersWithShipmentIds:shipmentIds]
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPBatch success:responseObject completion:^(EZPBatch *serverBatch, NSError *error) {
                              if (error) {
                                  NSLog(@"Error userInfo: %@", [error userInfo]);
                                  NSAssert(false, [error localizedDescription]);
                              }
                              [batch mergeWithObject:serverBatch];
                              completion(nil);
                          }];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(error);
                      }];
}

- (void)addShipmentsSynchronously:(NSArray *)shipmentIds toBatch:(EZPBatch *)batch
{
    EZPBatch *serverBatch = [self POST:[NSString stringWithFormat:@"batches/%@/add_shipments", batch.itemId]
                            parameters:[batch parametersWithShipmentIds:shipmentIds] responseClass:[EZPBatch class]];
    [batch mergeWithObject:serverBatch];
}

- (void)removeShipmentsWithShipments:(NSArray *)shipments fromBatch:(EZPBatch *)batch completion:(void(^)(NSError *error))completion
{
    [self removeShipments:[batch shipmentIdsWithShipments:shipments] fromBatch:batch completion:completion];
}

- (void)removeShipments:(NSArray *)shipmentIds fromBatch:(EZPBatch *)batch completion:(void(^)(NSError *error))completion
{
    NSAssert(batch.itemId, @"batch.itemId == nil");
    [self.sessionManager POST:[NSString stringWithFormat:@"batches/%@/remove_shipments", batch.itemId]
                   parameters:[batch parametersWithShipmentIds:shipmentIds]
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPBatch success:responseObject completion:^(EZPBatch *serverBatch, NSError *error) {
                              if (error) {
                                  NSLog(@"Error userInfo: %@", [error userInfo]);
                                  NSAssert(false, [error localizedDescription]);
                              }
                              [batch mergeWithObject:serverBatch];
                              completion(nil);
                          }];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(error);
                      }];
}
@end
