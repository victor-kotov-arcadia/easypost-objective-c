//
//  EZPClient+User.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPUser.h"

@interface EZPClient (User)
/**
 * Retrieve a User from its id. If no id is specified, it returns the user for the api_key specified
 * REQUIRES kLiveSecretAPIKey
 */
- (void)retrieveUser:(NSString *)itemId completion:(EZPRequestCompletion)completion;
- (EZPUser *)retrieveUser:(NSString *)itemId;
/**
 * Retrieve the users for the api_key specified
 * REQUIRES kLiveSecretAPIKey
 */
- (void)retrieveUsers:(EZPRequestCompletion)completion;
- (NSArray *)retrieveListOfUsers;
/**
 * Create a child user for the account associated with the api_key specified
 * REQUIRES kLiveSecretAPIKey
 */
- (void)createUserWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPUser *)createUserWithParameters:(NSDictionary *)parameters;
/**
 * Update the User associated with the api_key specified
 * REQUIRES kLiveSecretAPIKey
 */
- (void)updateUser:(EZPUser *)user withParameters:(NSDictionary *)parameters completion:(void(^)(NSError *error))completion;
- (void)updateUserSynchronously:(EZPUser *)user withParameters:(NSDictionary *)parameters;

@end
