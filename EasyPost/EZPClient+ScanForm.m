//
//  EZPClient+ScanForm.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Synchronous.h"
#import "EZPClient+Private.h"
#import "EZPClient+ScanForm.h"
#import "EZPScanFormList.h"
#import "AFHTTPRequestOperationManager+Synchronous.h"

@implementation EZPClient (ScanForm)

- (void)listScanFormsWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager GET:@"scan_forms"
                  parameters:parameters
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPScanForm success:responseObject class:[EZPScanFormList class] completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPScanFormList *)listOfScanFormsWithParameters:(NSDictionary *)parameters
{
    EZPScanFormList *list = [self GET:@"scan_forms" parameters:parameters responseClass:[EZPScanFormList class]];
    list.filters = [parameters mutableCopy];
    return list;
}

@end
