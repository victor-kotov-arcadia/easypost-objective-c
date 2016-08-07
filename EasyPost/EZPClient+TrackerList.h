//
//  EZPClient+TrackerList.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 07/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPTrackerList.h"

@interface EZPClient (TrackerList)
/**
 * Get the next page of trackers based on the previous list parameters
 */
- (EZPTrackerList *)nextTrackerListFor:(EZPTrackerList *)previousList;
@end
