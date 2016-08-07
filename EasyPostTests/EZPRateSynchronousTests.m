
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>

#import "EZPClient+Rate.h"
#import "EZPClient+Shipment.h"
#import "EZPClient+Parcel.h"
#import "EZPAddress.h"

@interface EZPRateSynchronousTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPRateSynchronousTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testRetrieve {
    EZPShipment *shipment = [self shipment];
    [self.client fetchRatesForShipmentSynchronously:shipment];
    EZPRate *rate = [self.client retrieveRate:shipment.rates[0].itemId];
    XCTAssertTrue([rate.itemId isEqualToString:shipment.rates[0].itemId]);

    XCTAssertNotNil(rate.rate);
    XCTAssertNotNil(rate.currency);
    XCTAssertNotNil(rate.list_rate);
    XCTAssertNotNil(rate.list_currency);
}

#pragma mark

- (EZPShipment *)shipment {
    NSDictionary *parcelDictionary = @{@"length": @8,
                                       @"width": @6,
                                       @"height": @5,
                                       @"weight": @10};
    EZPParcel *parcel = [[EZPParcel alloc] initWithDictionary:parcelDictionary];

    EZPShipment *shipment = [EZPShipment new];
    shipment.from_address = [self fromAddress];
    shipment.to_address = [self toAddress];
    shipment.parcel = parcel;
    shipment.reference = @"ShipmentRef";

    return shipment;
}

- (EZPAddress *)toAddress {
    NSDictionary *toAddressDictionary = @{@"company": @"Simpler Postage Inc",
                                          @"street1": @"164 Townsend Street",
                                          @"street2": @"Unit 1",
                                          @"city": @"San Francisco",
                                          @"state": @"CA",
                                          @"country": @"US",
                                          @"zip": @"94107"};
    EZPAddress *toAddress = [[EZPAddress alloc] initWithDictionary:toAddressDictionary];
    XCTAssertNotNil(toAddress);
    return toAddress;
}

- (EZPAddress *)fromAddress {
    NSDictionary *fromAddressDictionary = @{@"name": @"Andrew Tribone",
                                            @"street1": @"480 Fell St",
                                            @"street2": @"#3",
                                            @"city": @"San Francisco",
                                            @"state": @"CA",
                                            @"country": @"US",
                                            @"zip": @"94102"};
    EZPAddress *fromAddress = [[EZPAddress alloc] initWithDictionary:fromAddressDictionary];
    XCTAssertNotNil(fromAddress);
    return fromAddress;
}

@end
