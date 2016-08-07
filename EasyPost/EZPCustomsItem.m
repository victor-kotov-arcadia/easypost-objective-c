
// Created by Sinisa Drpa, 2015.

#import "EZPCustomsItem.h"
#import "EZPRequest.h"

#import "AFNetworking.h"

@implementation EZPCustomsItem

+ (NSDictionary *)propertyMap {
   return @{@"id": @"itemId",
            @"description": @"itemDescription"
            };
}

@end
