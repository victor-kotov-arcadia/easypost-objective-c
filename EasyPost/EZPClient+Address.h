//
//  EZPClient+Address.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPAddress.h"

@interface EZPClient (Address)
/**
 * Retrieve an address from its id
 */
- (void)retrieveAddress:(NSString *)addressId completion:(EZPRequestCompletion)completion;
- (EZPAddress *)retrieveAddress:(NSString *)addressId;
/**
 * Create an address
 */
- (void)createAddressWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPAddress *)createAddressWithParameters:(NSDictionary *)parameters;
- (void)createAddress: (EZPAddress *)address completion:(EZPRequestCompletion)completion;
- (void)createAddressSynchronously: (EZPAddress *)address;
/**
 * Verify an address
 */
- (void)verifyAddress:(EZPAddress *)address withCarrier:(NSString *)carrier completion:(EZPRequestCompletion)completion;
- (void)verifyAddressSynchronously:(EZPAddress *)address withCarrier:(NSString *)carrier;
/**
 * First create then verify the newly created address
 */
- (void)createAndVerifyAddressWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPAddress *)createAndVerifyAddressWithParameters:(NSDictionary *)parameters;

@end
