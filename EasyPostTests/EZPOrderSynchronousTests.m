
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>

#import "EZPClient+Order.h"
#import "EZPClient+Shipment.h"
#import "EZPClient+Address.h"
#import "EZPParcel.h"
#import "EZPCarrierAccount.h"

@interface EZPOrderSynchronousTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPOrderSynchronousTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testCreateAndRetrieveOrder {
    NSDictionary *parameters = [[self order] toDictionaryWithPrefix:@"order"];
    EZPOrder *order = [self.client createOrderWithParameters:parameters];

    XCTAssertNotNil(order.itemId);
    XCTAssertTrue([order.reference isEqualToString:@"OrderRef"]);

    EZPOrder *retrieved = [self.client retrieveOrder:order.itemId];
    XCTAssertTrue([order.itemId isEqualToString:retrieved.itemId]);
}

// FAILS: Request failed: client error (422)?
// "error": {
//   "code": "SHIPMENT.RATES.UNAVAILABLE",
//   "message": "Missing required data to get rates.",
//   "errors": []
// }
- (void)xstestCreateFromInstance {
    EZPOrder *order = [EZPOrder new];
    order.to_address = [self.client createAddressWithParameters:[[self toAddress] toDictionaryWithPrefix:@"address"]];
    order.from_address = [self.client createAddressWithParameters:[[self fromAddress] toDictionaryWithPrefix:@"address"]];
    order.reference = @"OrderRef",
    order.shipments = @[
        [self.client createShipmentWithParameters:[[self shipment] toDictionaryWithPrefix:@"shipment"]]
    ];

    [self.client createOrderSynchronously:order];

    XCTAssertNotNil(order.itemId);
    XCTAssertTrue([order.reference isEqualToString:@"OrderRef"]);
}

- (void)testBuyOrder {
    NSDictionary *parameters = [[self order] toDictionaryWithPrefix:@"order"];
    EZPOrder *order = [self.client createOrderWithParameters:parameters];
    [self.client buyOrderSynchronously:order withCarrier:@"USPS" service:@"Priority"];
    XCTAssertNotNil(order.shipments[0].postage_label);
}

#pragma mark

- (EZPOrder *)order {
    EZPOrder *order = [EZPOrder new];
    order.to_address = [self toAddress];
    order.from_address = [self fromAddress];
    order.reference = @"OrderRef";
    order.shipments = @[[self shipment], [self shipment]];

    return order;
}

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
