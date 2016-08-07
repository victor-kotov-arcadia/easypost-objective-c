//
//  EZPClient+Shipment.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPShipment.h"
#import "EZPClient+ShipmentList.h"

@interface EZPClient (Shipment)
/**
 * Get list of shipments
 */
- (void)listShipments:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPShipmentList *)listOfShipmentsWithParameters:(NSDictionary *)parameters;
/**
 * Retrieve a Shipment from its id
 */
- (void)retrieveShipment:(NSString *)itemId completion:(EZPRequestCompletion)completion;
- (EZPShipment *)retrieveShipment:(NSString *)itemId;
/**
 * Create a Shipment
 */
- (void)createShipmentWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (void)createShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion;

- (EZPShipment *)createShipmentWithParameters:(NSDictionary *)parameters;
- (void)createShipmentSynchronously:(EZPShipment *)shipment;
/**
 * Populate the rates property for the shipment
 */
- (void)fetchRatesForShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion;
- (void)fetchRatesForShipmentSynchronously:(EZPShipment *)shipment;
/**
 * Purchase a label for the shipment with the given rate
 */
- (void)buyShipment:(EZPShipment *)shipment withRate:(EZPRate *)rate completion:(void(^)(NSError *error))completion;
- (void)buyShipmentSynchronously:(EZPShipment *)shipment withRate:(EZPRate *)rate;
/**
 * Insure shipment for the given amount
 */
- (void)insureShipment:(EZPShipment *)shipment forAmount:(double)amount completion:(void(^)(NSError *error))completion;
- (void)insureShipmentSynchronously:(EZPShipment *)shipment forAmount:(double)amount;
/**
 * Send a refund request to the carrier the shipment was purchased from
 */
- (void)refundShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion;
- (void)refundShipmentSynchronously:(EZPShipment *)shipment;
/**
 * Generate a postage label for the shipment
 */
- (void)generateLabel:(NSString *)fileFormat forShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion;
- (void)generateLabelSynchronously:(NSString *)fileFormat forShipment:(EZPShipment *)shipment;
/**
 * Generate a stamp for the shipment
 */
- (void)generateStampForShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion;
- (void)generateStampForShipmentSynchronously:(EZPShipment *)shipment;
/**
 * Generate a stamp for this shipment
 */
- (void)generateBarcodeForShipment:(EZPShipment *)shipment completion:(void(^)(NSError *error))completion;
- (void)generateBarcodeForShipmentSynchronously:(EZPShipment *)shipment;
/**
 * Get the lowest rate for the shipment. Optionally whitelist/blacklist carriers and servies from the search
 */
- (void)lowestRateForShipment:(EZPShipment *)shipment includeCarriers:(NSArray *)includeCarriers includeServices:(NSArray *)includeServices excludeCarriers:(NSArray *)excludeCarriers excludeServices:(NSArray *)excludeServices completion:(void(^)(EZPRate *lowestRate))completion;

- (EZPRate *)lowestRateForShipmentSynchronously:(EZPShipment *)shipment includeCarriers:(NSArray *)includeCarriers includeServices:(NSArray *)includeServices excludeCarriers:(NSArray *)excludeCarriers excludeServices:(NSArray *)excludeServices;

- (EZPRate *)lowestRateForShipment:(EZPShipment *)shipment;
@end
