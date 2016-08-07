//
//  EZPClient+ScanFormList.m
//  EasyPost
//
//  Created by Dmitry Rodionov on 06/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient+Synchronous.h"
#import "EZPClient+ScanForm.h"
#import "EZPClient+ScanFormList.h"

@implementation EZPClient (ScanFormList)

- (EZPScanFormList *)nextScanFormListFor:(EZPScanFormList *)previousList
{
    previousList.filters = previousList.filters ? previousList.filters : [NSMutableDictionary dictionary];
    previousList.filters[@"before_id"] = [previousList.scan_forms lastObject].itemId;
    return [self listOfScanFormsWithParameters:previousList.filters];
}

@end
