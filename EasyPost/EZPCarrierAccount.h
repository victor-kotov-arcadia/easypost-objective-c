
// Created by Sinisa Drpa, 2015.

#import "EZPObject.h"

@interface EZPCarrierAccount : EZPObject

@property (copy) NSString *itemId;
@property (strong) NSDate *created_at;
@property (strong) NSDate *updated_at;
@property (copy) NSString *carrierDescription;
@property (copy) NSString *reference;
@property (copy) NSString *readable;
@property (strong) NSDictionary *credentials;
@property (strong) NSDictionary *test_credentials;

@end
