
// Created by Sinisa Drpa, 2015.

#import "EZPTracker.h"
#import "EZPRequest.h"

#import "EZPTrackingDetail.h"

#import "OCMapper.h"
#import "AFNetworking.h"

@implementation EZPTracker

+ (InCodeMappingProvider *)mappingProvider {
   InCodeMappingProvider *mappingProvider = [[InCodeMappingProvider alloc] init];
   NSDictionary *propertyMap = [EZPObject propertyMap];
   for (NSString *key in propertyMap) {
      [mappingProvider mapFromDictionaryKey:key toPropertyKey:propertyMap[key] forClass:[self class]];
   }
   
   [mappingProvider mapFromDictionaryKey:@"tracking_details" toPropertyKey:@"tracking_details"
                          withObjectType:[EZPTrackingDetail class] forClass:[self class]];
   
   return mappingProvider;
}

@end
