//
//  EZPClient+CustomsInfo.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+Synchronous.h"
#import "EZPClient+CustomsInfo.h"

@implementation EZPClient (CustomsInfo)

- (void)retrieveCustomsInfo:(NSString *)itemId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"customs_infos/%@", itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPCustomsInfo success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPCustomsInfo *)retrieveCustomsInfo:(NSString *)itemId
{
    NSParameterAssert(itemId);
    return [self GET:[NSString stringWithFormat:@"customs_infos/%@", itemId]
          parameters:nil responseClass:[EZPCustomsInfo class]];
}

- (void)createCustomsInfoWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"customs_infos"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPCustomsInfo success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPCustomsInfo *)createCustomsInfoWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"customs_infos" parameters:parameters responseClass:[EZPCustomsInfo class]];
}

@end
