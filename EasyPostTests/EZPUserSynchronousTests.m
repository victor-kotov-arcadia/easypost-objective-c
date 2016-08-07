
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>

#import "EZPClient+User.h"
#import "EZPConfiguration.h"

@interface EZPUserSynchronousTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPUserSynchronousTests

- (void)setUp {
    [super setUp];
    self.client = [[EZPClient alloc] initWithSecretKey:kLiveSecretAPIKey];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testRetrieve {
    NSArray *users = [self.client retrieveListOfUsers];
    XCTAssertNotNil(users);
}

- (void)testCreateAndUpdate {
    EZPUser *user = [self.client createUserWithParameters:@{@"user[name]": @"Test Name"}];
    XCTAssertNotNil(user.itemId);

    [self.client updateUserSynchronously:user withParameters:@{@"name": @"NewTest Name"}];
    XCTAssertEqualObjects(user.name, @"NewTest Name");
}

@end
