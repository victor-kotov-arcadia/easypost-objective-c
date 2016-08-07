//
//  EZPClient+Item.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Synchronous.h"
#import "EZPClient+Private.h"
#import "EZPClient+Item.h"

@implementation EZPClient (Item)

- (void)retrieveItem:(NSString *)itemId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"items/%@", itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPItem success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPItem *)retrieveItem:(NSString *)itemId;
{
    NSParameterAssert(itemId);
    return [self GET:[NSString stringWithFormat:@"items/%@", itemId]
          parameters:nil responseClass:[EZPItem class]];
}

- (void)createItemWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"items"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPItem success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPItem *)createItemWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"items" parameters:parameters responseClass:[EZPItem class]];
}

- (void)retrieveItemWithName:(NSString *)name value:(NSString *)value completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(name);
    NSParameterAssert(value);
    [self.sessionManager GET:[NSString stringWithFormat:@"items/retrieve_reference/?%@=%@", name, value]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPItem success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPItem *)retrieveItemWithName:(NSString *)name value:(NSString *)value
{
    NSParameterAssert(name);
    NSParameterAssert(value);
    return [self GET:[NSString stringWithFormat:@"items/retrieve_reference/?%@=%@", name, value]
          parameters:nil responseClass:[EZPItem class]];
}

@end
