//
//  EZPClient+CustomsItem.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPCustomsItem.h"

@interface EZPClient (CustomsItem)
/**
 * Retrieve a CustomsItem from its id
 */
- (void)retrieveCustomsItem:(NSString *)itemId completion:(EZPRequestCompletion)completion;
- (EZPCustomsItem *)retrieveCustomsItem:(NSString *)itemId;
/**
 * Create a CustomsItem
 */
- (void)createCustomsItemWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPCustomsItem *)createCustomsItemWithParameters:(NSDictionary *)parameters;
@end
