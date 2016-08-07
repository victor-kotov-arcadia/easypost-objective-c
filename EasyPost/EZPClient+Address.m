//
//  EZPClient+Address.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+Address.h"
#import "EZPClient+Synchronous.h"

@implementation EZPClient (Address)

- (void)retrieveAddress:(NSString *)addressId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(addressId);
    [self.sessionManager GET:[NSString stringWithFormat:@"addresses/%@", addressId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPAddress success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPAddress *)retrieveAddress:(NSString *)addressId
{
    NSParameterAssert(addressId);
    NSString *path = [NSString stringWithFormat:@"addresses/%@", addressId];
    return [self GET:path parameters:nil responseClass:[EZPAddress class]];
}

- (void)createAddressWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"addresses"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPAddress success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPAddress *)createAddressWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"addresses" parameters:parameters responseClass:[EZPAddress class]];
}

- (void)createAddress: (EZPAddress *)address completion:(EZPRequestCompletion)completion
{
    if (address.itemId) {
        [NSException raise:NSInternalInconsistencyException format:@"Resource Already Created"];
    }

    NSDictionary *parameters = [address toDictionaryWithPrefix:@"address"];
    [self createAddressWithParameters:parameters completion:^(EZPAddress *address, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
            NSAssert(false, nil);
        }
        completion(address, error);
    }];
}

- (void)createAddressSynchronously: (EZPAddress *)address
{
    if (address.itemId) {
        [NSException raise:NSInternalInconsistencyException format:@"Resource Already Created"];
    }

    NSDictionary *parameters = [address toDictionaryWithPrefix:@"address"];
    EZPAddress *response = [self createAddressWithParameters:parameters];
    [address mergeWithObject:response];
}

- (void)createAndVerifyAddressWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"addresses/create_and_verify"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPAddress success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPAddress *)createAndVerifyAddressWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"addresses/create_and_verify" parameters:parameters
           rootObject:@"address" responseClass:[EZPAddress class]];
}

- (void)verifyAddress: (EZPAddress *)address withCarrier:(NSString *)carrier completion:(EZPRequestCompletion)completion
{
    if (!address.itemId) {
        [self createAddress:address completion:^(EZPAddress *serverAddress, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", [error localizedDescription]);
                NSAssert(false, nil);
            }
            [self _verifyAddress:serverAddress withCarrier:carrier completion:completion];
        }];
    }
    else {
        [self _verifyAddress:address withCarrier:carrier completion:completion];
    }
}

- (void)verifyAddressSynchronously:(EZPAddress *)address withCarrier:(NSString *)carrier
{
    if (!address.itemId) {
        [self createAddressSynchronously:address];
    }

    NSDictionary *parameters;
    if (carrier) {
        parameters = @{@"carrier": carrier};
    }

    EZPAddress *response = [self GET:[NSString stringWithFormat:@"addresses/%@/verify", address.itemId]
                          parameters:nil rootObject:@"address" responseClass:[EZPAddress class]];
    [address mergeWithObject:response];
}

- (void)_verifyAddress:(EZPAddress *)address withCarrier:(NSString *)carrier completion:(EZPRequestCompletion)completion
{
    NSAssert(address.itemId, @"self.itemId == nil");
    [self retrieveAddress:address.itemId completion:completion];
}

@end
