
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+Shipment.h"
#import "EZPAddress.h"
#import "EZPParcel.h"
#import "EZPRate.h"

static CGFloat const kRequestTimeout = 15.0;

@interface EZPShipmentTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPShipmentTests

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
    [self.client listShipments:nil completion:^(NSArray *shipments, NSError *error) {
        if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
        }
        XCTAssertNotNil(shipments);

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
    [self.client createShipmentWithParameters:[self parameters] completion:^(EZPShipment *shipment, NSError *error) {
        if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
        }
        XCTAssertNotNil(shipment);
        //NSLog(@"SHIPMENT: %@", shipment);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testCreateFromItself {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    EZPShipment *shipment = [self shipment];
    [self.client createShipment:shipment completion:^(NSError *error) {
        if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
        }
        XCTAssertTrue([[shipment reference] isEqualToString:@"ShipmentRef"]);

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
    EZPShipment *shipment = [self shipment];
    [self.client createShipment:shipment completion:^(NSError *error) {
        if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
        }
        XCTAssertTrue([[shipment reference] isEqualToString:@"ShipmentRef"]);

        NSString *retrievedId = [shipment itemId];
        XCTAssertNotNil(retrievedId);

        [self.client retrieveShipment:[shipment itemId] completion:^(EZPShipment *shipment, NSError *error) {
            if (error) {
                XCTFail(@"Error: %@", [error localizedDescription]);
            }
            XCTAssertNotNil(shipment);
            XCTAssertTrue([[shipment itemId] isEqualToString:retrievedId]);

            [expectation fulfill];
        }];

    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testGetRatesWithoutCreate {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    EZPShipment *shipment = [self shipment];
    [self.client fetchRatesForShipment:shipment completion:^(NSError *error) {
        if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
        }
        XCTAssertNotNil([shipment rates]);
        //NSLog(@"[shipment rates]: %@", [shipment rates]);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testCreateAndBuyPlusInsurance {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    EZPShipment *shipment = [self shipment];

    [self.client fetchRatesForShipment:shipment completion:^(NSError *error) {
        if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
        }
        XCTAssertTrue([shipment.rates count] != 0);
        [self.client buyShipment:shipment withRate:shipment.rates[0] completion:^(NSError *error) {
            if (error) {
                XCTFail(@"Error: %@", [error localizedDescription]);
            }
            XCTAssertNotNil(shipment.postage_label);
            [self.client insureShipment:shipment forAmount:100.1 completion:^(NSError *error) {
                XCTAssertFalse([[shipment insurance] isEqualToString:@"100.1"]);
                [expectation fulfill];
            }];
        }];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout*3 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testRefund {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    [self buyShipment:^(EZPShipment *shipment, NSError *error) {
        if (error) XCTFail(@"Error: %@", [error localizedDescription]);
        XCTAssertNotNil(shipment);

        [self.client refundShipment:shipment completion:^(NSError *error) {
            if (error) XCTFail(@"Error: %@", [error localizedDescription]);
            XCTAssertNotNil(shipment.refund_status);

            [expectation fulfill];
        }];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testGenerateLabelStampBarcode {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    [self buyShipment:^(EZPShipment *shipment, NSError *error) {
        if (error) XCTFail(@"Error: %@", [error localizedDescription]);
        XCTAssertNotNil(shipment);

        [self.client generateLabel:@"pdf" forShipment:shipment completion:^(NSError *error) {
            if (error) {
                XCTFail(@"Error: %@", [error localizedDescription]);
            }
            XCTAssertNotNil(shipment.postage_label);

            [self.client generateStampForShipment:shipment completion:^(NSError *error) {
                if (error) {
                    XCTFail(@"Error: %@", [error localizedDescription]);
                }
                XCTAssertNotNil(shipment.stamp_url);

                [self.client generateBarcodeForShipment:shipment completion:^(NSError *error) {
                    if (error) {
                        XCTFail(@"Error: %@", [error localizedDescription]);
                    }
                    XCTAssertNotNil(shipment.barcode_url);

                    [expectation fulfill];
                }];
            }];
        }];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout*3 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testLowestRate1 {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    EZPShipment *shipment = [self shipmentWithRates];
    [self.client lowestRateForShipment:shipment includeCarriers:nil includeServices:nil excludeCarriers:nil excludeServices:nil completion:^(EZPRate *lowestRate) {
        XCTAssertTrue([[[self lowestUSPS] rate] isEqualToString:[lowestRate rate]]);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout*3 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testLowestRate2 {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    EZPShipment *shipment = [self shipmentWithRates];
    [self.client lowestRateForShipment:shipment includeCarriers:@[@"UPS"] includeServices:nil excludeCarriers:nil excludeServices:nil completion:^(EZPRate *lowestRate) {
        XCTAssertTrue([[[self lowestUPS] rate] isEqualToString:[lowestRate rate]]);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout*3 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testLowestRate3 {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    EZPShipment *shipment = [self shipmentWithRates];
    [self.client lowestRateForShipment:shipment includeCarriers:nil includeServices:@[@"Priority"] excludeCarriers:nil excludeServices:nil completion:^(EZPRate *lowestRate) {
        XCTAssertTrue([[[self highestUSPS] rate] isEqualToString:[lowestRate rate]]);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout*3 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testLowestRate4 {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    EZPShipment *shipment = [self shipmentWithRates];
    [self.client lowestRateForShipment:shipment includeCarriers:nil includeServices:nil excludeCarriers:@[@"USPS"] excludeServices:nil completion:^(EZPRate *lowestRate) {
        XCTAssertTrue([[[self lowestUPS] rate] isEqualToString:[lowestRate rate]]);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout*3 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testLowestRate5 {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    EZPShipment *shipment = [self shipmentWithRates];
    [self.client lowestRateForShipment:shipment includeCarriers:nil includeServices:nil excludeCarriers:nil excludeServices:@[@"ParcelSelect"] completion:^(EZPRate *lowestRate) {
        XCTAssertTrue([[[self highestUSPS] rate] isEqualToString:[lowestRate rate]]);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout*3 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testLowestRate6 {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    EZPShipment *shipment = [self shipmentWithRates];
    [self.client lowestRateForShipment:shipment includeCarriers:@[@"FedEx"] includeServices:nil excludeCarriers:nil excludeServices:nil completion:^(EZPRate *lowestRate) {
        XCTAssertNil(lowestRate);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout*3 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

- (void)testCarrierAccountsString {
    XCTestExpectation *expectation = [self expectationWithDescription:@""];
    NSDictionary *parameters = @{@"shipment[to_address][id]": @"adr_HrBKVA85",
                                 @"shipment[from_address][id]": @"adr_VtuTOj7o",
                                 @"shipment[parcel][id]": @"prcl_WDv2VzHp",
                                 @"shipment[customs_info][id]": @"cstinfo_bl5sE20Y",
                                 @"shipment[carrier_accounts][0][id]": @"ca_qn6QC6fd"
                                 };

    [self.client createShipmentWithParameters:parameters completion:^(EZPShipment *shipment, NSError *error) {
        if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
        }
        XCTAssertNotNil(shipment);
        for (EZPRate *rate in shipment.rates) {
            XCTAssertTrue([@"ca_qn6QC6fd" isEqualToString:rate.carrier_account_id]);
        }

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:kRequestTimeout*3 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Timeout: %@", error);
        }
    }];
}

#pragma mark - Helpers

- (NSDictionary *)parameters {
    return @{@"shipment[to_address][id]": @"adr_HrBKVA85",
             @"shipment[from_address][id]": @"adr_VtuTOj7o",
             @"shipment[parcel][id]": @"prcl_WDv2VzHp",
             @"shipment[customs_info][id]": @"cstinfo_bl5sE20Y",
             @"shipment[carrier_accounts][0][id]": @"ca_12345678",
             @"shipment[carrier_accounts][1][id]": @"ca_23456789"
             };
}

- (EZPShipment *)shipmentWithRates {
    EZPShipment *shipment = [self shipment];
    shipment.rates = @[[self highestUSPS], [self lowestUSPS], [self highestUPS], [self lowestUPS]];

    return shipment;
}

- (EZPRate *)lowestUSPS {
    return [[EZPRate alloc] initWithDictionary:@{@"rate": @"1.0", @"carrier": @"USPS", @"service": @"ParcelSelect"}];
}

- (EZPRate *)highestUSPS {
    return [[EZPRate alloc] initWithDictionary:@{@"rate": @"10.0", @"carrier": @"USPS", @"service": @"Priority"}];
}

- (EZPRate *)lowestUPS {
    return [[EZPRate alloc] initWithDictionary:@{@"rate": @"2.0", @"carrier": @"UPS", @"service": @"ParcelSelect"}];
}

- (EZPRate *)highestUPS {
    return [[EZPRate alloc] initWithDictionary:@{@"rate": @"20.0", @"carrier": @"UPS", @"service": @"Priority"}];
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

- (void)buyShipment:(EZPRequestCompletion)completion {
    EZPShipment *shipment = [self shipment];
    [self.client createShipment:shipment completion:^(NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        [self.client fetchRatesForShipment:shipment completion:^(NSError *error) {
            if (error) {
                completion(nil, error);
                return;
            }
            [self.client buyShipment:shipment withRate:[[shipment rates] firstObject] completion:^(NSError *error) {
                if (error) {
                    completion(nil, error);
                    return;
                }
                
                completion(shipment, nil);
            }];
        }];
    }];
}

@end
