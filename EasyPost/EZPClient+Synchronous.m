//
//  EZPClient+Synchronous.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 06/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+Synchronous.h"
#import "EZPClient+Order.h"
#import "AFHTTPRequestOperationManager+Synchronous.h"

@interface EZPObject ()
+ (id)resultObjectWithResponse:(id)responseObject;
@end

@implementation EZPClient (Synchronous)

- (id)GET:(NSString *)path parameters:(NSDictionary *)parameters responseClass:(Class)cls {
    return [self GET:path parameters:parameters rootObject:nil responseClass:cls];
}

- (id)GET:(NSString *)path parameters:(NSDictionary *)parameters rootObject:(NSString *)rootObject responseClass:(Class)cls {
    NSError *error;
    NSDictionary *response = [self.operationManager syncGET:path
                                                parameters:parameters
                                                 operation:nil
                                                     error:&error];
    if (error) {
        NSAssert(false, [error localizedDescription]);
    }
    NSDictionary *objectDictionary = rootObject ? response[rootObject] : response;
    id object = error ? nil: [cls performSelector:@selector(resultObjectWithResponse:) withObject:objectDictionary];
    return object;
}

- (id)POST:(NSString *)path parameters:(NSDictionary *)parameters responseClass:(Class)cls {
    return [self POST:path parameters:parameters rootObject:nil responseClass:cls];
}

- (id)POST:(NSString *)path parameters:(NSDictionary *)parameters rootObject:(NSString *)rootObject responseClass:(Class)cls {
    NSError *error;
    NSDictionary *response = [self.operationManager syncPOST:path
                                                 parameters:parameters
                                                  operation:nil
                                                      error:&error];
    if (error) {
        NSAssert(false, [error localizedDescription]);
    }
    NSDictionary *objectDictionary = rootObject ? response[rootObject] : response;
    //NSLog(@"objectDictionary: %@", objectDictionary);
    id object = error ? nil: [cls performSelector:@selector(resultObjectWithResponse:) withObject:objectDictionary];
    return object;
}

- (id)PUT:(NSString *)path parameters:(NSDictionary *)parameters responseClass:(Class)cls {
    NSError *error;
    NSDictionary *response = [self.operationManager syncPUT:path
                                                parameters:parameters
                                                 operation:nil
                                                     error:&error];
    if (error) {
        NSAssert(false, [error localizedDescription]);
    }
    id object = error ? nil: [cls performSelector:@selector(resultObjectWithResponse:) withObject:response];
    return object;
}

- (void)DELETE:(NSString *)path parameters:(NSDictionary*)parameters
{
    NSError *error = nil;
    id response = [self.operationManager syncDELETE:path parameters:parameters operation:nil error:&error];
    if (!response && error) {
        NSAssert(false, [error localizedDescription]);
    }
}

- (id)PATCH:(NSString *)path parameters:(NSDictionary*)parameters responseClass:(Class)cls
{
    NSError *error = nil;
    id response = [self.operationManager syncPATCH:path parameters:parameters operation:nil error:&error];
    if (!response && error) {
        NSAssert(false, [error localizedDescription]);
    }
    id object = error ? nil: [cls performSelector:@selector(resultObjectWithResponse:) withObject:response];
    return object;
}

@end
