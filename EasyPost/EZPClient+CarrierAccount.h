//
//  EZPClient+CarrierAccount.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPCarrierAccount.h"

@interface EZPClient (CarrierAccount)

/**
 * Get list of carrier accounts
 * REQUIRES kLiveSecretAPIKey
 */
- (void)listCarrierAccounts:(EZPRequestCompletion)completion;
- (NSArray *)listOfCarrierAccounts;
/**
 * Retrieve a CarrierAccount from its id
 * REQUIRES kLiveSecretAPIKey
 */
- (void)retrieveCarrierAccount:(NSString *)carrierAccountId completion:(EZPRequestCompletion)completion;
- (EZPCarrierAccount *)retrieveCarrierAccount:(NSString *)carrierAccountId;
/**
 * Create a CarrierAccount
 * REQUIRES kLiveSecretAPIKey
 */
- (void)createCarrierAccountWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPCarrierAccount *)createCarrierAccountWithParameters:(NSDictionary *)parameters;
/**
 * Remove a CarrierAccount from your account by its id
 * REQUIRES kLiveSecretAPIKey
 */
- (void)deleteCarrierAccount:(NSString *)carrierAccountId completion:(void(^)(NSError *error))completion;
- (void)deleteCarrierAccountSynchronously:(NSString *)carrierAccountId;
/**
 * Update a CarrierAccount
 * REQUIRES kLiveSecretAPIKey
 */
- (void)updateCarrierAccount:(NSString *)carrierAccountId parameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPCarrierAccount *)updateCarrierAccountSynchronously:(NSString *)itemId parameters:(NSDictionary *)parameters;

@end
