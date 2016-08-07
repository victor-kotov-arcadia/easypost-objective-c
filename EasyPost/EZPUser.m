
// Created by Sinisa Drpa, 2015.

#import "EZPUser.h"
#import "EZPRequest.h"
#import "AFNetworking.h"

@interface EZPObject ()
- (void)setKeyValuesWithDictionary:(NSDictionary *)dictionary;
@end

@implementation EZPUser

// NOTE(rodionovd): Some of our properties are NSUIntegers which can not be mapped directly from
// NSStrings (came from JSON). We manually convert these strings into NSNumbers before mapping further
- (void)setKeyValuesWithDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *fixedDictionary = [dictionary mutableCopy];
    for (NSString *affectedKey in @[@"price_per_shipment", @"recharge_amount",
                                    @"recharge_threshold", @"secondary_recharge_amount"]) {
        fixedDictionary[affectedKey] = @([dictionary[affectedKey] integerValue]);
    }
    return [super setKeyValuesWithDictionary: fixedDictionary];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    NSArray *affectedKeys = @[@"price_per_shipment", @"recharge_amount",
                              @"recharge_threshold", @"secondary_recharge_amount"];
    if ([affectedKeys containsObject:key]) {
        [super setValue:@([value integerValue]) forKey:key];
    } else {
        [super setValue:value forKey:key];
    }
}

@end
