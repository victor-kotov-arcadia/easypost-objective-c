
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+Pickup.h"
#import "EZPAddress.h"
#import "EZPParcel.h"
#import "EZPClient+Shipment.h"

static CGFloat const kRequestTimeout = 25.0;

@interface EZPPickupTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPPickupTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)xtestCreateThenRetrieve {
   XCTestExpectation *expectation = [self expectationWithDescription:@""];
   EZPShipment *shipment = [self shipment];
   [self.client createShipment:shipment completion:^(NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      EZPPickup *pickup = [self pickup];
      pickup.shipment = shipment;
      
      [self.client createPickup:pickup completion:^(NSError *error) {
         if (error) {
            XCTFail(@"Error: %@", [error localizedDescription]);
         }
         XCTAssertNotNil([pickup itemId]);
         XCTAssertTrue([pickup.address.street1 isEqualToString:@"164 Townsend Street"]);
         [self.client retrievePickup:[pickup itemId] completion:^(EZPPickup *retrieved, NSError *error) {
            if (error) {
               XCTFail(@"Error: %@", [error localizedDescription]);
            }
            XCTAssertTrue([retrieved.itemId isEqualToString:pickup.itemId]);
            
            [expectation fulfill];
         }];
      }];
   }];
   
   [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
      if (error) {
         XCTFail(@"Timeout: %@", error);
      }
   }];
}

// FAILS: messages": [{
// "carrier": "USPS",
// "type": "rate_error",
// "message": "Service availability unknown. serverError = 1012   serverMessage = More than one facility found for address."
// }],
- (void)xtestBuyAndCancel {
   XCTestExpectation *expectation = [self expectationWithDescription:@""];
   NSDictionary *parameters = [[self pickup] toDictionaryWithPrefix:@"pickup"];
   [self.client createPickupWithParameters:parameters completion:^(EZPPickup *pickup, NSError *error) {
       [self.client buyPickup:pickup withCarrier:@"FEDEX" service:@"Same Day" completion:^(NSError *error) {
         XCTAssertNotNil(pickup.confirmation);
         
         [self.client cancelPickup:pickup completion:^(NSError *error) {
            XCTAssertTrue([pickup.status isEqualToString:@"canceled"]);
            [expectation fulfill];
         }];
      }];
   }];   
   
   [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
      if (error) {
         XCTFail(@"Timeout: %@", error);
      }
   }];
}


#pragma mark

- (EZPPickup *)pickup {
   EZPPickup *pickup = [EZPPickup new];
   pickup.is_account_address = NO;
   pickup.address = [self fromAddress];
   pickup.min_datetime = [NSDate date];
   pickup.max_datetime = [NSDate date];
   
   return pickup;
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
