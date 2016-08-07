//
//  EZPClient+Synchronous.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 06/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"

@interface EZPClient (Synchronous)

- (id)GET:(NSString *)path parameters:(NSDictionary *)parameters responseClass:(Class)cls;
- (id)GET:(NSString *)path parameters:(NSDictionary *)parameters rootObject:(NSString *)rootObject responseClass:(Class)cls;

- (id)POST:(NSString *)path parameters:(NSDictionary *)parameters responseClass:(Class)cls;
- (id)POST:(NSString *)path parameters:(NSDictionary *)parameters rootObject:(NSString *)rootObject responseClass:(Class)cls;

- (id)PUT:(NSString *)path parameters:(NSDictionary *)parameters responseClass:(Class)cls;

- (void)DELETE:(NSString *)path parameters:(NSDictionary*)parameters;

- (id)PATCH:(NSString *)path parameters:(NSDictionary*)parameters responseClass:(Class)cls;

@end
