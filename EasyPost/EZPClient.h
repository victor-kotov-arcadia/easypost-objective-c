//
//  EZPClient.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPObject.h"

@interface EZPClient : NSObject

@property (readwrite, copy) NSString *APISecretKey;

/// Returns a client object initiated with the given secret key
- (instancetype)initWithSecretKey:(NSString *)secretKey;
/// Returns a shared client object initiated with the secret key from EZPConfiguration
+ (instancetype)defaultClient;

@end
