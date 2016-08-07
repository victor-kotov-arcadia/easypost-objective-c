
// Created by Sinisa Drpa, 2015.

#import <XCTest/XCTest.h>

#import "EZPClient+CustomsInfo.h"

@interface EZPCustomsInfoSynchronousTests : XCTestCase
@property (strong) EZPClient *client;
@end

@implementation EZPCustomsInfoSynchronousTests

- (void)setUp {
    [super setUp];
    self.client = [EZPClient defaultClient];
}

- (void)tearDown {
    self.client = nil;
    [super tearDown];
}

@end
