
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>

#import "EZPClient+CustomsItem.h"

@interface EZPCustomsItemSynchronousTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPCustomsItemSynchronousTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testCreateAndRetrieve {
   EZPCustomsItem *item = [self.client createCustomsItemWithParameters:[self parameters]];
   EZPCustomsItem *retrieved = [self.client retrieveCustomsItem:item.itemId];
   XCTAssertTrue([[retrieved itemId] isEqualToString:[item itemId]]);
   XCTAssertEqual(10.0, retrieved.value);
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
