//
//  EZPClient+Order.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Synchronous.h"
#import "EZPClient+Private.h"
#import "EZPClient+Order.h"
#import "EZPRate.h"

@implementation EZPClient (Order)

- (void)retrieveOrder:(NSString *)itemId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"orders/%@", itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPOrder success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPOrder *)retrieveOrder:(NSString *)itemId
{
    NSParameterAssert(itemId);
    return [self GET:[NSString stringWithFormat:@"orders/%@", itemId]
          parameters:nil responseClass:[EZPOrder class]];
}

- (void)createOrderWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"orders"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPOrder success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPOrder *)createOrderWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"orders" parameters:parameters responseClass:[EZPOrder class]];
}

- (void)createOrder:(EZPOrder *)order completion:(void(^)(NSError *error))completion
{
    if (order.itemId) {
        [NSException raise:NSInternalInconsistencyException format:@"Resource Already Created"];
    }

    NSDictionary *parameters = [order toDictionaryWithPrefix:@"order"];
    [self createOrderWithParameters:parameters completion:^(EZPOrder *serverOrder, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
            NSAssert(false, nil);
            completion(error);
        }
        [order mergeWithObject:serverOrder];
    }];
}

- (void)createOrderSynchronously: (EZPOrder *)order
{
    if (order.itemId) {
        [NSException raise:NSInternalInconsistencyException format:@"Resource Already Created"];
    }

    NSDictionary *parameters = [order toDictionaryWithPrefix:@"order"];
    EZPOrder *response = [self createOrderWithParameters:parameters];
    [order mergeWithObject:response];
}

- (void)buyOrder:(EZPOrder *)order withRate:(EZPRate *)rate completion:(void(^)(NSError *error))completion
{
    [self buyOrder:order withCarrier:rate.carrier service:rate.service completion:completion];
}

- (void)buyOrderSynchronously:(EZPOrder *)order withRate:(EZPRate *)rate
{
    [self buyOrderSynchronously:order withCarrier:rate.carrier service:rate.service];
}

- (void)buyOrder:(EZPOrder *)order withCarrier:(NSString *)carrier service:(NSString *)service completion:(void(^)(NSError *error))completion
{
    NSParameterAssert(order.itemId);
    NSParameterAssert(carrier);
    NSParameterAssert(service);

    [self.sessionManager POST:[NSString stringWithFormat:@"orders/%@/buy", order.itemId]
                   parameters:@{@"carrier": carrier, @"service": service}
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPOrder success:responseObject completion:^(EZPOrder *serverOrder, NSError *error) {
                              if (error) {
                                  NSLog(@"Error userInfo: %@", [error userInfo]);
                                  NSAssert(false, [error localizedDescription]);
                              }
                              [order mergeWithObject:serverOrder];
                              completion(nil);
                          }];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(error);
                      }];
}

- (void)buyOrderSynchronously:(EZPOrder *)order withCarrier:(NSString *)carrier service:(NSString *)service
{
    NSParameterAssert(order.itemId);
    NSParameterAssert(carrier);
    NSParameterAssert(service);
    EZPOrder *response = [self POST:[NSString stringWithFormat:@"orders/%@/buy", order.itemId]
                         parameters:@{@"carrier": carrier, @"service": service}
                      responseClass:[EZPOrder class]];
    [order mergeWithObject:response];
}

@end
