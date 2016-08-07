
// Created by Sinisa Drpa, 2015.

#import "EZPCustomsInfo.h"
#import "EZPCustomsItem.h"
#import "EZPRequest.h"

#import "AFNetworking.h"

@implementation EZPCustomsInfo

+ (InCodeMappingProvider *)mappingProvider {
   InCodeMappingProvider *mappingProvider = [[InCodeMappingProvider alloc] init];
   NSDictionary *propertyMap = [EZPObject propertyMap];
   for (NSString *key in propertyMap) {
      [mappingProvider mapFromDictionaryKey:key toPropertyKey:propertyMap[key] forClass:[self class]];
   }
   
   [mappingProvider mapFromDictionaryKey:@"customs_items" toPropertyKey:@"customs_items"
                          withObjectType:[EZPCustomsItem class] forClass:[self class]];
   
   return mappingProvider;
}

@end
