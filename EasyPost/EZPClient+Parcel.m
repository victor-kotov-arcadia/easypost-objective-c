//
//  EZPClient+Parcel.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Synchronous.h"
#import "EZPClient+Private.h"
#import "EZPClient+Parcel.h"

@implementation EZPClient (Parcel)

- (void)retrieveParcel:(NSString *)parcelId completion:(EZPRequestCompletion)completion
{
    NSParameterAssert(parcelId);
    [self.sessionManager GET:[NSString stringWithFormat:@"parcels/%@", parcelId]
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPParcel success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}


- (EZPParcel *)retrieveParcel:(NSString *)itemId
{
    NSParameterAssert(itemId);
    return [self GET:[NSString stringWithFormat:@"parcels/%@", itemId]
          parameters:nil responseClass:[EZPParcel class]];
}

- (void)retrieveParcels:(EZPRequestCompletion)completion
{
    [self.sessionManager GET:@"parcels"
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         [EZPParcel success:responseObject completion:completion];
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                         completion(nil, error);
                     }];
}

- (NSArray *)listOfParcels
{
    return [self GET:@"parcels" parameters:nil responseClass:[EZPParcel class]];
}

- (void)createParcelWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion
{
    [self.sessionManager POST:@"parcels"
                   parameters:parameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          [EZPParcel success:responseObject completion:completion];
                      } failure:^(NSURLSessionDataTask *task, NSError *error) {
                          completion(nil, error);
                      }];
}

- (EZPParcel *)createParcelWithParameters:(NSDictionary *)parameters
{
    return [self POST:@"parcels" parameters:parameters responseClass:[EZPParcel class]];
}
@end
