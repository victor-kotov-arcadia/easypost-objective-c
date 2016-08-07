//
//  EZPClient+Tracker.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+Tracker.h"
#import "EZPClient+Synchronous.h"

@implementation EZPClient (Tracker)

- (void)listTrackers:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager GET:@"trackers"
                  parameters:parameters
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPTracker success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPTrackerList *)listOfTrackersWithParameters:(NSDictionary *)parameters
{
    EZPTrackerList *response = [self GET:@"trackers" parameters:parameters responseClass:[EZPTrackerList class]];
    response.filters = [parameters mutableCopy];
    return response;
}

- (void)createTrackerForCarrier:(NSString *)carrier trackingCode:(NSString *)trackingCode completion:(EZPRequestCompletion)completion
{
    NSDictionary *parameters = @{@"tracker[tracking_code]": trackingCode,
                                 @"tracker[carrier]": carrier};
    [self.sessionManager POST:@"trackers"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPTracker success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPTracker *)createTrackerForCarrierSynchronously:(NSString *)carrier trackingCode:(NSString *)trackingCode
{
    NSParameterAssert(carrier);
    NSParameterAssert(trackingCode);
    NSDictionary *parameters = @{@"tracker[tracking_code]": trackingCode,
                                 @"tracker[carrier]": carrier};
    return [self POST:@"trackers" parameters:parameters responseClass:[EZPTracker class]];
}

- (void)retrieveTracker:(NSString *)itemId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(itemId);
    [self.sessionManager GET:[NSString stringWithFormat:@"trackers/%@", itemId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPTracker success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (EZPTracker *)retrieveTracker:(NSString *)itemId
{
    NSParameterAssert(itemId);
    return [self GET:[NSString stringWithFormat:@"trackers/%@", itemId]
          parameters:nil responseClass:[EZPTracker class]];
}
@end
