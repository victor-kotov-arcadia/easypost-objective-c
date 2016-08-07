
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>

#import "EZPClient+Parcel.h"
#import "EZPClient+Shipment.h"

@interface EZPParcelSynchronousTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPParcelSynchronousTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testRetrieveParcels
{
    NSArray *parcels = [self.client listOfParcels];
    XCTAssertNotEqual(0, parcels.count);
}

- (void)testCreateAndRetrieve {
    EZPParcel *parcel = [self.client createParcelWithParameters:[self parameters]];

    EZPParcel *retrieved = [self.client retrieveParcel:parcel.itemId];
    XCTAssertTrue([parcel.itemId isEqualToString:retrieved.itemId]);
}

- (void)testPredefinedPackage {
    EZPParcel *parcel = [EZPParcel new];
    parcel.weight = 1.8;
    parcel.length = 2.0;
    parcel.width = 3.0;
    parcel.height = 4.0;
    parcel.predefined_package = @"SMALLFLATRATEBOX";

    EZPShipment *shipment = [EZPShipment new];
    shipment.parcel = parcel;
    [self.client createShipmentSynchronously:shipment];

    XCTAssertEqual(4.0, shipment.parcel.height);
    XCTAssertTrue([@"SMALLFLATRATEBOX" isEqualToString:shipment.parcel.predefined_package]);
}

#pragma mark

- (NSDictionary *)parameters {
    NSDictionary *parameters = @{@"parcel[length]": @20.2,
                                 @"parcel[width]": @10.9,
                                 @"parcel[height]": @5,
                                 @"parcel[weight]": @65.9
                                 };
    return parameters;
}

@end
