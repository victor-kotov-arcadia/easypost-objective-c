
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+Address.h"

@interface EZPAddressSynchronousTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPAddressSynchronousTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testCreateAndRetrieve {
    NSDictionary *parameters = [[self toAddress] toDictionaryWithPrefix:@"address"];
    EZPAddress *address = [self.client createAndVerifyAddressWithParameters:parameters];
    XCTAssertNotNil(address.itemId);
    XCTAssertEqualObjects(address.company.lowercaseString, @"Simpler Postage Inc".lowercaseString);
    XCTAssertNil(address.name);

    EZPAddress *retrieved = [self.client retrieveAddress:address.itemId];
    XCTAssertTrue([address.itemId isEqualToString:retrieved.itemId]);
}

- (void)testCreateInstance {
    EZPAddress *address = [self toAddress];
    [self.client createAddressSynchronously:address];
    XCTAssertNotNil(address.itemId);
}

- (void)testCreateAndVerify {
    NSDictionary *parameters = [[self toAddress] toDictionaryWithPrefix:@"address"];
    EZPAddress *address = [self.client createAndVerifyAddressWithParameters:parameters];
    XCTAssertNotNil(address.itemId);
    XCTAssertEqualObjects(address.company.lowercaseString, @"Simpler Postage Inc".lowercaseString);
    XCTAssertNil(address.name);
}

- (void)testVerify {
    NSDictionary *parameters = [[self toAddress] toDictionaryWithPrefix:@"address"];
    EZPAddress *address = [self.client createAddressWithParameters:parameters];
    [self.client verifyAddressSynchronously:address withCarrier:nil];

    XCTAssertNotNil(address.itemId);
    XCTAssertEqualObjects(address.company.lowercaseString, @"Simpler Postage Inc".lowercaseString);
    XCTAssertNil(address.name);
    XCTAssertTrue(address.residential);
}

- (void)testVerifyCarrier {
    NSDictionary *parameters = [[self toAddress] toDictionaryWithPrefix:@"address"];
    EZPAddress *address = [self.client createAddressWithParameters:parameters];
    [self.client verifyAddressSynchronously:address withCarrier:@"usps"];
    XCTAssertNotNil(address.itemId);
    XCTAssertEqualObjects(address.company.lowercaseString, @"Simpler Postage Inc".lowercaseString);
    // NOTE(rodionovd): apperently EasyPost combines street1 and street2 here
    XCTAssertEqualObjects([address.street1 stringByAppendingString:address.street2], @"164 TOWNSEND ST UNIT 1");
    XCTAssertNil(address.name);
}

- (void)testVerifyBeforeCreate {
    EZPAddress *address = [self toAddress];
    [self.client verifyAddressSynchronously:address withCarrier:nil];
    XCTAssertNotNil(address.itemId);
}

#pragma mark

- (EZPAddress *)toAddress {
    NSDictionary *toAddressDictionary = @{@"company": @"Simpler Postage Inc",
                                          @"street1": @"164 Townsend Street",
                                          @"street2": @"Unit 1",
                                          @"city": @"San Francisco",
                                          @"state": @"CA",
                                          @"country": @"US",
                                          @"zip": @"94107",
                                          @"residential": @YES};
    EZPAddress *toAddress = [[EZPAddress alloc] initWithDictionary:toAddressDictionary];
    XCTAssertNotNil(toAddress);
    return toAddress;
}

@end
