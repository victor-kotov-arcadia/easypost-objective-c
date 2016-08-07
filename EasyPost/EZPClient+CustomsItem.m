//
//  EZPClient+CustomsItem.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+CustomsItem.h"
#import "EZPClient+Synchronous.h"

@implementation EZPClient (CustomsItem)

- (void)retrieveCustomsItem:(NSString *)itemId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"customs_items/%@", itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPCustomsItem success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPCustomsItem *)retrieveCustomsItem:(NSString *)itemId
{
    NSParameterAssert(itemId);
    return [self GET:[NSString stringWithFormat:@"customs_items/%@", itemId]
          parameters:nil responseClass:[EZPCustomsItem class]];
}

- (void)createCustomsItemWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"customs_items"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPCustomsItem success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPCustomsItem *)createCustomsItemWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"customs_items" parameters:parameters responseClass:[EZPCustomsItem class]];
}

@end
