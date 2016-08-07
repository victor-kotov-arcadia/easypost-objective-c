
// Created by Sinisa Drpa, 2015.

#import "EZPShipment.h"
#import "EZPRate.h"
#import "EZPFee.h"
#import "EZPForm.h"
#import "EZPCarrierAccount.h"
#import "EZPRequest.h"
#import "NSDictionaryUtility.h"

#import "EZPCustomsInfo.h"
#import "EZPCustomsItem.h"

#import "AFNetworking.h"

@implementation EZPShipment

- (EZPRate *)_lowestRateFromRates:(NSArray *)theRates includeCarriers:(NSArray *)includeCarriers includeServices:(NSArray *)includeServices excludeCarriers:(NSArray *)excludeCarriers excludeServices:(NSArray *)excludeServices {
   NSMutableSet *ratesSet;
   if (!includeCarriers && !includeServices) {
      ratesSet = [NSMutableSet setWithArray:theRates];
   } else {
      ratesSet = [NSMutableSet set];
   }

   if (includeCarriers) {
      BOOL exists = NO;
      for (EZPRate *rate in theRates) {
         if ([includeCarriers containsObject:rate.carrier]) {
            [ratesSet addObject:rate];
            exists = YES;
         }
      }
      if (!exists) {
         return nil;
      }
   }
   
   if (includeServices) {
      BOOL exists = NO;
      for (EZPRate *rate in theRates) {
         if ([includeServices containsObject:rate.service]) {
            [ratesSet addObject:rate];
            exists = YES;
         }
      }
      if (!exists) {
         return nil;
      }
   }
   
   if (excludeCarriers) {
      for (EZPRate *rate in theRates) {
         if ([excludeCarriers containsObject:rate.carrier]) {
            [ratesSet removeObject:rate];
         }
      }
   }
   
   if (excludeServices) {
      for (EZPRate *rate in theRates) {
         if ([excludeServices containsObject:rate.service]) {
            [ratesSet removeObject:rate];
         }
      }
   }
   
   NSMutableArray *rates = [[ratesSet allObjects] mutableCopy];
   // From lower to greater
   [rates sortUsingComparator:^NSComparisonResult(EZPRate *rate1, EZPRate *rate2) {
      double obj1 = [[rate1 rate] doubleValue];
      double obj2 = [[rate2 rate] doubleValue];
      if (obj1 > obj2) {
         return NSOrderedDescending;
      }
      if (obj1 < obj2) {
         return NSOrderedAscending;
      }
      return NSOrderedSame;
   }];
   
   return [rates firstObject];
}

+ (InCodeMappingProvider *)mappingProvider {
   InCodeMappingProvider *mappingProvider = [[InCodeMappingProvider alloc] init];
   NSDictionary *propertyMap = [EZPObject propertyMap];
   for (NSString *key in propertyMap) {
      [mappingProvider mapFromDictionaryKey:key toPropertyKey:propertyMap[key] forClass:[self class]];
   }
   
   [mappingProvider mapFromDictionaryKey:@"rates" toPropertyKey:@"rates"
                          withObjectType:[EZPRate class] forClass:[self class]];
   [mappingProvider mapFromDictionaryKey:@"id" toPropertyKey:@"itemId"
                                forClass:[EZPRate class]];
   
   [mappingProvider mapFromDictionaryKey:@"fees" toPropertyKey:@"fees"
                          withObjectType:[EZPFee class] forClass:[self class]];
   [mappingProvider mapFromDictionaryKey:@"forms" toPropertyKey:@"forms"
                          withObjectType:[EZPForm class] forClass:[self class]];
   
   [mappingProvider mapFromDictionaryKey:@"carrier_accounts" toPropertyKey:@"carrier_accounts"
                          withObjectType:[EZPCarrierAccount class] forClass:[self class]];
   [mappingProvider mapFromDictionaryKey:@"id" toPropertyKey:@"itemId"
                                forClass:[EZPCarrierAccount class]];
   
   [mappingProvider mapFromDictionaryKey:@"customs_items" toPropertyKey:@"customs_items"
                          withObjectType:[EZPCustomsItem class] forClass:[EZPCustomsInfo class]];
   
   return mappingProvider;
}

@end
