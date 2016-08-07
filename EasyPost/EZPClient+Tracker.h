//
//  EZPClient+Tracker.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPTracker.h"
#import "EZPClient+TrackerList.h"

@interface EZPClient (Tracker)
/**
 * Get list of trackers
 */
- (void)listTrackers:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPTrackerList *)listOfTrackersWithParameters:(NSDictionary *)parameters;
/**
 * Create a tracker for the given Carrier
 */
- (void)createTrackerForCarrier:(NSString *)carrier trackingCode:(NSString *)trackingCode completion:(EZPRequestCompletion)completion;
- (EZPTracker *)createTrackerForCarrierSynchronously:(NSString *)carrier trackingCode:(NSString *)trackingCode;
/**
 * Retrieve a Tracker from its id
 */
- (void)retrieveTracker:(NSString *)itemId completion:(EZPRequestCompletion)completion;
- (EZPTracker *)retrieveTracker:(NSString *)itemId;

@end
