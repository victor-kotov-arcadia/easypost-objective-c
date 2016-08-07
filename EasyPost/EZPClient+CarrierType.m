//
//  EZPClient+CarrierType.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+CarrierType.h"
#import "EZPClient+Synchronous.h"

@implementation EZPClient (CarrierType)

- (void)listCarrierTypes:(EZPRequestCompletion)completion
{
    [self.sessionManager GET:@"carrier_types"
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPCarrierType success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (NSArray *)listOfCarrierTypes
{
    return [self GET:@"carrier_types" parameters:nil responseClass:[EZPCarrierType class]];
}

@end
