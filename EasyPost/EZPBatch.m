
// Created by Sinisa Drpa, 2015.

#import "EZPBatch.h"
#import "EZPShipment.h"
#import "EZPRequest.h"

#import "AFNetworking.h"

@implementation EZPBatch

- (NSArray *)shipmentIdsWithShipments:(NSArray *)shipments {
   NSMutableArray *shipmentIds = [NSMutableArray array];
   for (NSString *shipmentId in shipmentIds) {
      [shipmentIds addObject:shipmentId];
   }
   return [shipmentIds copy];
}

- (NSDictionary *)parametersWithShipmentIds:(NSArray *)shipmentIds {
   NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
   for (NSUInteger i=0; i<[shipmentIds count]; i++) {
      NSString *shipmentId = shipmentIds[i];
      parameters[[NSString stringWithFormat:@"shipments[%li][id]", i]] = shipmentId;
   }
   return [parameters copy];
}

#pragma mark

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
   
   return mappingProvider;
}

@end
