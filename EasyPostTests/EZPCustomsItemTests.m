
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+CustomsItem.h"

static CGFloat const kRequestTimeout = 10.0;

@interface EZPCustomsItemTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPCustomsItemTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testCreate {
   XCTestExpectation *expectation = [self expectationWithDescription:@""];
   [self.client createCustomsItemWithParameters:[self parameters] completion:^(EZPCustomsItem *item, NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      XCTAssertNotNil(item);
      XCTAssertTrue([[item itemDescription] isEqualToString:@"T-shirt"]);
      
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
   [self.client createCustomsItemWithParameters:[self parameters] completion:^(EZPCustomsItem *item, NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      NSString *createdId = [item itemId];
      [self.client retrieveCustomsItem:createdId completion:^(EZPCustomsItem *item, NSError *error) {
         if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
         }
         XCTAssertNotNil(item);
         XCTAssertTrue([[item itemId] isEqualToString:createdId]);
         
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
   NSDictionary *parameters = @{@"customs_item[description]": @"T-shirt",
                                @"customs_item[quantity]": @"1",
                                @"customs_item[weight]": @"5",
                                @"customs_item[value]": @"10",
                                @"customs_item[hs_tariff_number]": @"123456",
                                @"customs_item[origin_country]": @"US"
                                };
   return parameters;
}

@end
