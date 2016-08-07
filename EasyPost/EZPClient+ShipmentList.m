//
//  EZPClient+ShipmentList.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 07/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Private.h"
#import "EZPClient+Shipment.h"
#import "EZPClient+Synchronous.h"
#import "EZPClient+ShipmentList.h"

@implementation EZPClient (ShipmentList)

- (EZPShipmentList *)nextShipmentListFor:(EZPShipmentList *)previousList
{
    previousList.filters = previousList.filters ?: [NSMutableDictionary dictionary];
    previousList.filters[@"before_id"] = previousList.shipments.lastObject.itemId;
    return [self listOfShipmentsWithParameters:previousList.filters];
}

@end
