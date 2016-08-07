
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>

#import "EZPClient+CarrierType.h"
#import "EZPConfiguration.h"

@interface EZPCarrierTypeSynchronousTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPCarrierTypeSynchronousTests

- (void)setUp {
    [super setUp];
    self.client = [[EZPClient alloc] initWithSecretKey:kLiveSecretAPIKey];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testAll {
   NSArray *types = [self.client listOfCarrierTypes];
   XCTAssertNotEqual(0, types.count);
}

@end
