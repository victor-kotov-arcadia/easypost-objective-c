
// Created by Sinisa Drpa, 2015.

#import "EZPItem.h"
#import "EZPRequest.h"

#import "AFNetworking.h"

@implementation EZPItem

+ (NSDictionary *)propertyMap {
   return @{@"id": @"itemId",
            @"description": @"itemDescription"
            };
}

@end
