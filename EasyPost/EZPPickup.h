
// Created by Sinisa Drpa, 2015.

#import "EZPObject.h"

@class EZPAddress;
@class EZPCarrierAccount;
@class EZPShipment;
@class EZPRate;

@interface EZPPickup : EZPObject

@property (copy) NSString *itemId;
@property (copy) NSString *mode;
@property (strong) NSDate *created_at;
@property (strong) NSDate *updated_at;
@property (copy) NSString *status;
@property (copy) NSString *name;
@property (copy) NSString *reference;
@property (strong) NSDate *min_datetime;
@property (strong) NSDate *max_datetime;
@property (assign) BOOL is_account_address;
@property (copy) NSString *instructions;
@property (strong) NSArray *messages;
@property (copy) NSString *confirmation;
@property (strong) EZPAddress *address;
@property (strong) EZPShipment *shipment;
@property (strong) NSArray<EZPCarrierAccount *> *carrier_accounts;
@property (strong) NSArray<EZPRate *> *pickup_rates;

@end
