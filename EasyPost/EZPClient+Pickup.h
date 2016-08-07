//
//  EZPClient+Pickup.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPPickup.h"

@interface EZPClient (Pickup)
/**
 * Retrieve a Pickup from its id
 */
- (void)retrievePickup:(NSString *)itemId completion:(EZPRequestCompletion)completion;
- (EZPPickup *)retrievePickup:(NSString *)itemId;
/**
 * Create a Pickup with parameters
 */
- (void)createPickupWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPPickup *)createPickupWithParameters:(NSDictionary *)parameters;
/**
 * Create a Pickup
 */
- (void)createPickup:(EZPPickup *)pickup completion:(void(^)(NSError *error))completion;
- (void)createPickupSynchronously:(EZPPickup *)pickup;
/**
 * Purchase a Pickup
 */
- (void)buyPickup:(EZPPickup *)pickup withCarrier:(NSString *)carrier service:(NSString *)service completion:(void(^)(NSError *error))completion;
- (void)buyPickupSynchronously:(EZPPickup *)pickup WithCarrier:(NSString *)carrier service:(NSString *)service;
/**
 * Cancel a Pickup
 */
- (void)cancelPickup:(EZPPickup *)pickup completion:(void(^)(NSError *error))completion;
- (void)cancelPickupSynchronously:(EZPPickup *)pickup;

@end
