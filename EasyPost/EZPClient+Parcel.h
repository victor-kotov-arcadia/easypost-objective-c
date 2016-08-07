//
//  EZPClient+Parcel.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPParcel.h"

@interface EZPClient (Parcel)
/**
 * Retrieve a parcel from its id
 */
- (void)retrieveParcel:(NSString *)parcelId completion:(EZPRequestCompletion)completion;
- (EZPParcel *)retrieveParcel:(NSString *)itemId;
/**
 * Retrieve parcels
 */
- (void)retrieveParcels:(EZPRequestCompletion)completion;
- (NSArray *)listOfParcels;
/**
 * Create an parcel
 */
- (void)createParcelWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPParcel *)createParcelWithParameters:(NSDictionary *)parameters;

@end
