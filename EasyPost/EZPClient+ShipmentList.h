//
//  EZPClient+ShipmentList.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 07/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPShipmentList.h"

@interface EZPClient (ShipmentList)
/**
 * Get the next page of shipments based on the previous list parameters
 */
- (EZPShipmentList *)nextShipmentListFor:(EZPShipmentList *)previousList;
@end
