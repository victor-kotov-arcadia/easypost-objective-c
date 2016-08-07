
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>
#import "EZPClient+User.h"
#import "EZPConfiguration.h"

static CGFloat const kRequestTimeout = 10.0;

@interface EZPUserTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPUserTests

- (void)setUp {
    [super setUp];
    // User API requires a Live secret key
    self.client = [[EZPClient alloc] initWithSecretKey:kLiveSecretAPIKey];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

- (void)testRetrieve {
   XCTestExpectation *expectation = [self expectationWithDescription:@""];
   [self.client retrieveUsers:^(NSArray *users, NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      XCTAssertNotNil(users);
      
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
   NSDictionary *parameters = @{@"user[name]": @"Child Name"};
   [self.client createUserWithParameters:parameters completion:^(EZPUser *user, NSError *error) {
      if (error) {
         XCTFail(@"Error: %@", [error localizedDescription]);
      }
      XCTAssertNotNil(user);
      XCTAssertTrue([[user name] isEqualToString:@"Child Name"]);
      
      [expectation fulfill];
   }];
   
   [self waitForExpectationsWithTimeout:kRequestTimeout handler:^(NSError *error) {
      if (error) {
         XCTFail(@"Timeout: %@", error);
      }
   }];
}

@end
