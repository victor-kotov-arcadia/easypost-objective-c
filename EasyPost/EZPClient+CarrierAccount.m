//
//  EZPClient+CarrierAccount.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+Synchronous.h"
#import "EZPClient+CarrierAccount.h"

@implementation EZPClient (CarrierAccount)

- (void)listCarrierAccounts:(EZPRequestCompletion)completion
{
    [self.sessionManager GET:@"carrier_accounts"
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPCarrierAccount success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (NSArray *)listOfCarrierAccounts
{
    return [self GET:@"carrier_accounts" parameters:nil responseClass:[EZPCarrierAccount class]];
}

- (void)retrieveCarrierAccount:(NSString *)carrierAccountId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(carrierAccountId);
    [self.sessionManager GET:[NSString stringWithFormat:@"carrier_accounts/%@", carrierAccountId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPCarrierAccount success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPCarrierAccount *)retrieveCarrierAccount:(NSString *)carrierAccountId
{
    NSParameterAssert(carrierAccountId);
    NSString *path = [NSString stringWithFormat:@"carrier_accounts/%@", carrierAccountId];
    return [self GET:path parameters:nil responseClass:[EZPCarrierAccount class]];
}

- (void)createCarrierAccountWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"carrier_accounts"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPCarrierAccount success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPCarrierAccount *)createCarrierAccountWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"carrier_accounts" parameters:parameters responseClass:[EZPCarrierAccount class]];
}

- (void)deleteCarrierAccount:(NSString *)carrierAccountId completion:(void(^)(NSError *error))completion
{
    NSParameterAssert(carrierAccountId);
    [self.sessionManager DELETE:[NSString stringWithFormat:@"carrier_accounts/%@", carrierAccountId]
                     parameters:nil
                        success:^(NSURLSessionDataTask *task, id responseObject) {
                            completion(nil);
                        } failure:^(NSURLSessionDataTask *task, NSError *error) {
                            completion(error);
                        }];
}

- (void)deleteCarrierAccountSynchronously:(NSString *)carrierAccountId
{
    NSParameterAssert(carrierAccountId);
    NSString *path = [NSString stringWithFormat:@"carrier_accounts/%@", carrierAccountId];
    [self DELETE:path parameters:nil];
}

- (void)updateCarrierAccount:(NSString *)itemId parameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager PATCH:[NSString stringWithFormat:@"carrier_accounts/%@", itemId]
                    parameters:parameters
                       success:^(NSURLSessionDataTask *task, id responseObject) {
                           EZPCarrierAccount *object = [[EZPCarrierAccount alloc] initWithDictionary:responseObject];
                           completion(object, nil);
                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                           completion(nil, error);
                       }];
}

- (EZPCarrierAccount *)updateCarrierAccountSynchronously:(NSString *)itemId parameters:(NSDictionary *)parameters
{
    NSParameterAssert(itemId);
    NSString *path = [NSString stringWithFormat:@"carrier_accounts/%@", itemId];
    EZPCarrierAccount *updatedAccount = [self PATCH:path parameters:parameters responseClass:[EZPCarrierAccount class]];
    return updatedAccount;
}

@end
