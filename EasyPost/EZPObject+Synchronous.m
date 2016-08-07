
// Created by Sinisa Drpa, 2015.

#import "EZPObject+Synchronous.h"
#import "EZPRequest.h"

#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager+Synchronous.h"

@implementation EZPObject (Synchronous)

+ (id)resultObjectWithResponse:(id)responseObject {
   return [EZPObject resultObjectWithResponse:responseObject class:[self class]];
}

+ (id)resultObjectWithResponse:(id)responseObject class:(Class)objectClass {
   InCodeMappingProvider *mappingProvider = [objectClass mappingProvider];
   
   ObjectMapper *objectMapper = [[ObjectMapper alloc] init];
   objectMapper.mappingProvider = mappingProvider;
   //objectMapper.loggingProvider = [[CommonLoggingProvider alloc] initWithLogLevel:LogLevelInfo];
   
   id object = [objectMapper objectFromSource:responseObject toInstanceOfClass:objectClass];
   NSAssert(object, @"Object == nil");
   //NSLog(@"ResponseObject: %@", responseObject);
   //NSLog(@"Object: %@", object);
   
   return object;
}

@end
