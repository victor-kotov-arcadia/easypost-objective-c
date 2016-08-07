//
//  EZPClient+Rate.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Synchronous.h"
#import "EZPClient+Private.h"
#import "EZPClient+Rate.h"

@implementation EZPClient (Rate)

- (void)retrieveRate:(NSString *)rateId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(rateId);
    [self.sessionManager GET:[NSString stringWithFormat:@"rates/%@", rateId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPRate success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPRate *)retrieveRate:(NSString *)rateId
{
    NSParameterAssert(rateId);
    return [self GET:[NSString stringWithFormat:@"rates/%@", rateId]
          parameters:nil responseClass:[EZPRate class]];
}

@end
