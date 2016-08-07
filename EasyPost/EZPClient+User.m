//
//  EZPClient+User.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+User.h"
#import "EZPClient+Private.h"
#import "EZPClient+Synchronous.h"

@implementation EZPClient (User)

- (void)retrieveUser:(NSString *)itemId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"users/%@", itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         EZPUser *object = [[EZPUser alloc] initWithDictionary:responseObject];
                         completion(object, nil);
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPUser *)retrieveUser:(NSString *)itemId
{
    NSParameterAssert(itemId);
    return [self GET:[NSString stringWithFormat:@"users/%@", itemId] parameters:nil responseClass:[EZPUser class]];
}

/**
 * Retrieve the users for the api_key specified
 * REQUIRES kLiveSecretAPIKey
 */
- (void)retrieveUsers:(EZPRequestCompletion)completion
{
    [self.sessionManager GET:@"users"
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         EZPUser *object = [[EZPUser alloc] initWithDictionary:responseObject];
                         completion(object, nil);
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (NSArray *)retrieveListOfUsers
{
    return [self GET:@"users" parameters:nil responseClass:[EZPUser class]];
}

/**
 * Create a child user for the account associated with the api_key specified
 * REQUIRES kLiveSecretAPIKey
 */
- (void)createUserWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"users"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          EZPUser *object = [[EZPUser alloc] initWithDictionary:responseObject];
                          completion(object, nil);
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPUser *)createUserWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"users" parameters:parameters responseClass:[EZPUser class]];
}

/**
 * Update the User associated with the api_key specified
 * REQUIRES kLiveSecretAPIKey
 */
- (void)updateUser:(EZPUser *)user withParameters:(NSDictionary *)parameters completion:(void(^)(NSError *error))completion
{
    NSParameterAssert(user.itemId);
    NSParameterAssert(parameters);
    [self.sessionManager PUT:[NSString stringWithFormat:@"users/%@", user.itemId]
                  parameters:@{@"user": parameters}
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         EZPUser *object = [[EZPUser alloc] initWithDictionary:responseObject];
                         [user mergeWithObject:object];
                         completion(nil);
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(error);
                     }];
}

- (void)updateUserSynchronously:(EZPUser *)user withParameters:(NSDictionary *)parameters
{
    NSParameterAssert(user.itemId);
    EZPUser *response = [self PATCH:[NSString stringWithFormat:@"users/%@", user.itemId]
                       parameters:@{@"user": parameters} responseClass:[EZPUser class]];
    [user mergeWithObject:response];
}

@end
