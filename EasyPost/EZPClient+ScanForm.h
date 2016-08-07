//
//  EZPClient+ScanForm.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPScanForm.h"
#import "EZPScanFormList.h"

@interface EZPClient (ScanForm)
/**
 * Get list of shipments
 */
- (void)listScanFormsWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPScanFormList *)listOfScanFormsWithParameters:(NSDictionary *)parameters;

@end
