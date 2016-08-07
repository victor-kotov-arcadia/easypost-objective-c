
// Created by Sinisa Drpa, 2015.

#import "EZPRate.h"
#import "EZPRequest.h"

#import "AFNetworking.h"

@implementation EZPRate

- (BOOL)isEqualToRate:(EZPRate *)rate {
   if (!rate) {
      return NO;
   }
   
   BOOL haveEqualServise = (!self.service && !rate.service) || [self.service isEqualToString:rate.service];
   BOOL haveEqualCarrier = (!self.carrier && !rate.carrier) || [self.carrier isEqualToString:rate.carrier];
   BOOL haveEqualRate    = (!self.rate && !rate.rate) || [self.rate isEqualToString:rate.rate];
   
   return haveEqualServise && haveEqualCarrier && haveEqualRate;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
   if (self == object) {
      return YES;
   }
   
   if (![object isKindOfClass:[EZPRate class]]) {
      return NO;
   }
   
   return [self isEqualToRate:(EZPRate *)object];
}

- (NSUInteger)hash {
   return [self.service hash] ^ [self.carrier hash] ^ [self.rate hash];
}

@end
