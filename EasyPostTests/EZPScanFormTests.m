
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+ScanForm.h"
#import "EZPScanFormList.h"

static CGFloat const kRequestTimeout = 15.0;

@interface EZPScanFormTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPScanFormTests

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
   [self.client listScanFormsWithParameters:nil completion:^(EZPScanFormList *scanFormList, NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      XCTAssertNotNil(scanFormList);
      for (EZPScanForm *form in [scanFormList scan_forms]) {
         XCTAssertNotNil(form);
      }
      
      [expectation fulfill];
   }];
   
   [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
      if (error) {
         XCTFail(@"Timeout: %@", error);
      }
   }];
}

@end
