
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+Tracker.h"

@interface EZPTrackerSynchronousTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPTrackerSynchronousTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testCreateAndRetrieve {
    EZPTracker *tracker = [self.client createTrackerForCarrierSynchronously:@"USPS" trackingCode:@"EZ1000000001"];
    XCTAssertTrue([[tracker tracking_code] isEqualToString:@"EZ1000000001"]);
    XCTAssertNotNil(tracker.est_delivery_date);
    XCTAssertNotNil(tracker.carrier);

    EZPTracker *retrieved = [self.client retrieveTracker:tracker.itemId];
    XCTAssertTrue([retrieved.itemId isEqualToString:tracker.itemId]);
}

- (void)testList {
    EZPTrackerList *trackerList = [self.client listOfTrackersWithParameters:nil];
    XCTAssertNotEqual(0, trackerList.trackers.count);

    EZPTrackerList *nextTrackerList = [self.client nextTrackerListFor:trackerList];
    XCTAssertNotEqual(trackerList.trackers[0].itemId, nextTrackerList.trackers[0].itemId);
}

@end
