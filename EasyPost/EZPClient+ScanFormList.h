//
//  EZPClient+ScanFormList.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 06/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPScanFormList.h"

@interface EZPClient (ScanFormList)
/**
 * Get the next page of scan forms based on the previous list parameters
 */
- (EZPScanFormList *)nextScanFormListFor:(EZPScanFormList *)previousList;

@end
