//
//  EZPClient+Pickup.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+Pickup.h"
#import "EZPClient+Synchronous.h"

@implementation EZPClient (Pickup)

- (void)retrievePickup:(NSString *)itemId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"pickups/%@", itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPPickup success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPPickup *)retrievePickup:(NSString *)itemId
{
    NSParameterAssert(itemId);
    return [self GET:[NSString stringWithFormat:@"pickups/%@", itemId]
          parameters:nil responseClass:[EZPPickup class]];
}

- (void)createPickupWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"pickups"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPPickup success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}
- (EZPPickup *)createPickupWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"pickups" parameters:parameters responseClass:[EZPPickup class]];
}

- (void)createPickup:(EZPPickup *)pickup completion:(void(^)(NSError *error))completion
{
    if (pickup.itemId) {
        [NSException raise:NSInternalInconsistencyException format:@"Resource Already Created"];
    }

    NSDictionary *parameters = [pickup toDictionaryWithPrefix:@"pickup"];
    [self createPickupWithParameters:parameters completion:^(EZPPickup *pickup, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
            NSAssert(false, nil);
            completion(error);
        }
        completion(nil);
    }];
}

- (void)createPickupSynchronously:(EZPPickup *)pickup
{
    if (pickup.itemId) {
        [NSException raise:NSInternalInconsistencyException format:@"Resource Already Created"];
    }

    NSDictionary *parameters = [pickup toDictionaryWithPrefix:@"pickup"];
    EZPPickup *response = [self createPickupWithParameters:parameters];
    [pickup mergeWithObject:response];
}

- (void)buyPickup:(EZPPickup *)pickup withCarrier:(NSString *)carrier service:(NSString *)service completion:(void(^)(NSError *error))completion
{
    NSAssert(pickup.itemId, @"pickup.itemId == nil");
    NSDictionary *parameters = @{@"carrier": carrier,
                                 @"service": service};
    [self.sessionManager POST:[NSString stringWithFormat:@"pickups/%@/buy", pickup.itemId]
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          completion(nil);
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(error);
                      }];
}

- (void)buyPickupSynchronously:(EZPPickup *)pickup WithCarrier:(NSString *)carrier service:(NSString *)service
{
    NSParameterAssert(pickup.itemId);
    NSParameterAssert(carrier);
    NSParameterAssert(service);
    EZPPickup *response = [self POST:[NSString stringWithFormat:@"orders/%@/buy", pickup.itemId]
                          parameters:@{@"carrier": carrier, @"service": service}
                       responseClass:[EZPPickup class]];
    [pickup mergeWithObject:response];
}

- (void)cancelPickup:(EZPPickup *)pickup completion:(void(^)(NSError *error))completion
{
    NSAssert(pickup.itemId, @"pickup.itemId == nil");
    [self.sessionManager POST:[NSString stringWithFormat:@"pickups/%@/cancel", pickup.itemId]
                   parameters:nil
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          completion(nil);
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(error);
                      }];
}

- (void)cancelPickupSynchronously:(EZPPickup *)pickup
{
    NSParameterAssert(pickup.itemId);
    EZPPickup *response = [self POST:[NSString stringWithFormat:@"pickups/%@/cancel", pickup.itemId]
                          parameters:nil responseClass:[EZPPickup class]];
    [pickup mergeWithObject:response];
}

@end
