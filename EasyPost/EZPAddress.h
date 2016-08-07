
// Created by Sinisa Drpa, 2015.

#import "EZPObject.h"

@interface EZPAddress : EZPObject

@property (copy) NSString *itemId;
@property (strong) NSDate *created_at;
@property (strong) NSDate *updated_at;
@property (copy) NSString *name;
@property (copy) NSString *company;
@property (copy) NSString *street1;
@property (copy) NSString *street2;
@property (copy) NSString *city;
@property (copy) NSString *state;
@property (copy) NSString *zip;
@property (copy) NSString *country;
@property (copy) NSString *phone;
@property (copy) NSString *email;
@property (assign) BOOL residential;
@property (copy) NSString *mode;
@property (copy) NSString *error;
@property (copy) NSString *message;

@end
