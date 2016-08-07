
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+Tracker.h"

static CGFloat const kRequestTimeout = 10.0;

@interface EZPTrackerTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPTrackerTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testList {
   XCTestExpectation *expectation = [self expectationWithDescription:@""];
   [self.client listTrackers:nil completion:^(NSArray *trackers, NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      XCTAssertNotNil(trackers);
      
      [expectation fulfill];
   }];
   
   [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
      if (error) {
         XCTFail(@"Timeout: %@", error);
      }
   }];
}

- (void)testCreate {
   XCTestExpectation *expectation = [self expectationWithDescription:@""];
   [self.client createTrackerForCarrier:@"USPS" trackingCode:@"EZ1000000001" completion:^(EZPTracker *tracker, NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      XCTAssertNotNil(tracker);
      XCTAssertTrue([[tracker tracking_code] isEqualToString:@"EZ1000000001"]);
      
      [expectation fulfill];
   }];
   
   [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
      if (error) {
         XCTFail(@"Timeout: %@", error);
      }
   }];
}

- (void)testCreateThenRetrieve {
   XCTestExpectation *expectation = [self expectationWithDescription:@""];
   [self.client createTrackerForCarrier:@"USPS" trackingCode:@"EZ1000000001" completion:^(EZPTracker *tracker, NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      XCTAssertNotNil(tracker);
      [self.client retrieveTracker:[tracker itemId] completion:^(EZPTracker *tracker, NSError *error) {
         if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
         }
         XCTAssertNotNil(tracker);
         XCTAssertTrue([[tracker tracking_code] isEqualToString:@"EZ1000000001"]);
         
         [expectation fulfill];
      }];
   }];
   
   [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
      if (error) {
         XCTFail(@"Timeout: %@", error);
      }
   }];
}

@end
