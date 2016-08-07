//
//  EZPClient+Batch.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPBatch.h"

@interface EZPClient (Batch)
/**
 * Retrieve a Batch from its id
 */
- (void)retrieveBatch:(NSString *)batchId completion:(EZPRequestCompletion)completion;
- (EZPBatch *)retrieveBatch:(NSString *)batchId;
/**
 * Create a Batch
 */
- (void)createBatchWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPBatch *)createBatchWithParameters:(NSDictionary *)parameters;
/**
 * Add shipments to a batch
 */
- (void)addShipmentsWithShipments:(NSArray *)shipments toBatch:(EZPBatch *)batch completion:(void(^)(NSError *error))completion;
- (void)addShipmentsWithShipmentsSynchronously:(NSArray *)shipments toBatch:(EZPBatch *)batch;

- (void)addShipments:(NSArray *)shipmentIds toBatch:(EZPBatch *)batch completion:(void(^)(NSError *error))completion;
- (void)addShipmentsSynchronously:(NSArray *)shipmentIds toBatch:(EZPBatch *)batch;
/**
 * Remove shipments from a batch
 */
- (void)removeShipmentsWithShipments:(NSArray *)shipments fromBatch:(EZPBatch *)batch completion:(void(^)(NSError *error))completion;
- (void)removeShipments:(NSArray *)shipmentIds fromBatch:(EZPBatch *)batch completion:(void(^)(NSError *error))completion;
@end
