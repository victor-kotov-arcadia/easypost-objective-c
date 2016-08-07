//
//  EZPClient+CustomsInfo.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPCustomsInfo.h"

@interface EZPClient (CustomsInfo)
/**
 * Retrieve a CustomsInfo from its id
 */
- (void)retrieveCustomsInfo:(NSString *)itemId completion:(EZPRequestCompletion)completion;
- (EZPCustomsInfo *)retrieveCustomsInfo:(NSString *)itemId;
/**
 * Create a CustomsInfo
 */
- (void)createCustomsInfoWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPCustomsInfo *)createCustomsInfoWithParameters:(NSDictionary *)parameters;

@end
