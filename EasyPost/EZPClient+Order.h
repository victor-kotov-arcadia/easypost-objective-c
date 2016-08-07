//
//  EZPClient+Order.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPOrder.h"

@interface EZPClient (Order)
/**
 * Retrieve an Order from its id or reference
 */
- (void)retrieveOrder:(NSString *)itemId completion:(EZPRequestCompletion)completion;
- (EZPOrder *)retrieveOrder:(NSString *)itemId;
/**
 * Create an Order
 */
- (void)createOrderWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (void)createOrder:(EZPOrder *)order completion:(void(^)(NSError *error))completion;

- (EZPOrder *)createOrderWithParameters:(NSDictionary *)parameters;
- (void)createOrderSynchronously: (EZPOrder *)order;

/**
 * Purchase a label for this shipment with the given rate
 */
- (void)buyOrder:(EZPOrder *)order withRate:(EZPRate *)rate completion:(void(^)(NSError *error))completion;
- (void)buyOrderSynchronously:(EZPOrder *)order withRate:(EZPRate *)rate;
/**
 * Purchase the shipments within this order with a carrier and service
 */
- (void)buyOrder:(EZPOrder *)order withCarrier:(NSString *)carrier service:(NSString *)service completion:(void(^)(NSError *error))completion;
- (void)buyOrderSynchronously:(EZPOrder *)order withCarrier:(NSString *)carrier service:(NSString *)service;

@end
