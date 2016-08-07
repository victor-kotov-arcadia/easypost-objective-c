
// Created by Sinisa Drpa, 2015.

#import "EZPObject.h"

@interface EZPUser : EZPObject

@property (copy) NSString *itemId;
@property (copy) NSString *parent_id;
@property (strong) NSDate *created_at;
@property (strong) NSDate *updated_at;
@property (copy) NSString *name;
@property (copy) NSString *email;
@property (copy) NSString *phone_number;
@property (copy) NSString *balance;
@property (assign) NSUInteger price_per_shipment;
@property (assign) NSUInteger recharge_amount;
@property (assign) NSUInteger secondary_recharge_amount;
@property (assign) NSUInteger recharge_threshold;
@property (strong) NSArray <EZPUser *> *children;

@end
