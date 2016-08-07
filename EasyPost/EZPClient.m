//
//  EZPClient.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPClient+Private.h"
#import "EZPConfiguration.h"

@implementation EZPClient

- (instancetype)initWithSecretKey:(NSString *)secretKey
{
    NSParameterAssert(secretKey);

    if ((self = [super init])) {
        _APISecretKey = secretKey;
    }
    return self;
}

+ (instancetype)defaultClient
{
    static id client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] initWithSecretKey:(kProductionEnviroment ? kLiveSecretAPIKey : kTestSecretAPIKey)];
    });
    return client;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:APIBaseURL()];
        [_sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", self.APISecretKey]
                                 forHTTPHeaderField:@"Authorization"];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }

    return _sessionManager;
}

- (AFHTTPRequestOperationManager *)operationManager
{
    if (!_operationManager) {
        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:APIBaseURL()];
        [_operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", self.APISecretKey]
                                   forHTTPHeaderField:@"Authorization"];
        _operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return _operationManager;
}

@end
