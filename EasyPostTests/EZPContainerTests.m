
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+Container.h"

static CGFloat const kRequestTimeout = 10.0;

@interface EZPContainerTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPContainerTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testCreateThenRetrieve {
   XCTestExpectation *expectation = [self expectationWithDescription:@""];
   [self.client createContainerWithParameters:[self parameters] completion:^(EZPContainer *container, NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      XCTAssertNotNil(container);
      [self.client retrieveContainer:[container itemId] completion:^(EZPContainer *container, NSError *error) {
         if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
         }
         XCTAssertNotNil(container);
         XCTAssertTrue([container length] == 20.2);
         XCTAssertTrue([container width] == 10.9);
         XCTAssertTrue([container height] == 5);
         
         [expectation fulfill];
      }];
   }];
   
   [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
      if (error) {
         XCTFail(@"Timeout: %@", error);
      }
   }];
}

- (NSDictionary *)parameters {
   NSDictionary *parameters = @{@"container[name]": @"SampleContainer",
                                @"container[length]": @20.2,
                                @"container[width]": @10.9,
                                @"container[height]": @5
                                };
   return parameters;
}

@end
