//
//  EZPClient+TrackerList.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 07/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Tracker.h"
#import "EZPClient+TrackerList.h"

@implementation EZPClient (TrackerList)

- (EZPTrackerList *)nextTrackerListFor:(EZPTrackerList *)previousList
{
    previousList.filters = previousList.filters ?: [NSMutableDictionary dictionary];
    previousList.filters[@"before_id"] = previousList.trackers.lastObject.itemId;
    return [self listOfTrackersWithParameters:previousList.filters];
}

@end
