
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+CarrierType.h"
#import "EZPConfiguration.h"

static CGFloat const kRequestTimeout = 10.0;

@interface EZPCarrierTypeTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPCarrierTypeTests

- (void)setUp {
    [super setUp];
    self.client = [[EZPClient alloc] initWithSecretKey:kLiveSecretAPIKey];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testRetrieve {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    [self.client listCarrierTypes:^(NSArray *carrierTypes, NSError *error) {
        if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
        }
        XCTAssertNotNil(carrierTypes);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

@end
