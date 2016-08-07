
// Created by Sinisa Drpa, 2015.

#import "EZPOrder.h"
#import "EZPRequest.h"
#import "EZPRate.h"
#import "EZPShipment.h"
#import "EZPContainer.h"
#import "EZPItem.h"

#import "AFNetworking.h"

@implementation EZPOrder

+ (InCodeMappingProvider *)mappingProvider {
   InCodeMappingProvider *mappingProvider = [[InCodeMappingProvider alloc] init];
   NSDictionary *propertyMap = [EZPObject propertyMap];
   for (NSString *key in propertyMap) {
      [mappingProvider mapFromDictionaryKey:key toPropertyKey:propertyMap[key] forClass:[self class]];
   }
   
   [mappingProvider mapFromDictionaryKey:@"shipments" toPropertyKey:@"shipments"
                          withObjectType:[EZPShipment class] forClass:[self class]];
   [mappingProvider mapFromDictionaryKey:@"id" toPropertyKey:@"itemId"
                                forClass:[EZPShipment class]];
   
   [mappingProvider mapFromDictionaryKey:@"rates" toPropertyKey:@"rates"
                          withObjectType:[EZPRate class] forClass:[self class]];
   [mappingProvider mapFromDictionaryKey:@"id" toPropertyKey:@"itemId"
                                forClass:[EZPRate class]];
   
   [mappingProvider mapFromDictionaryKey:@"containers" toPropertyKey:@"containers"
                          withObjectType:[EZPContainer class] forClass:[self class]];
   [mappingProvider mapFromDictionaryKey:@"id" toPropertyKey:@"itemId"
                                forClass:[EZPContainer class]];
   
   [mappingProvider mapFromDictionaryKey:@"items" toPropertyKey:@"items"
                          withObjectType:[EZPItem class] forClass:[self class]];
   [mappingProvider mapFromDictionaryKey:@"id" toPropertyKey:@"itemId"
                                forClass:[EZPItem class]];
   
   return mappingProvider;
}

@end
