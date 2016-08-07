//
//  EZPClient+Item.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPItem.h"

@interface EZPClient (Item)
/**
 * Retrieve an Item from its id or reference
 */
- (void)retrieveItem:(NSString *)itemId completion:(EZPRequestCompletion)completion;
- (EZPItem *)retrieveItem:(NSString *)itemId;
/**
 * Create an Item
 */
- (void)createItemWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPItem *)createItemWithParameters:(NSDictionary *)parameters;
/**
 * Retrieve a Item from a custom reference
 */
- (void)retrieveItemWithName:(NSString *)name value:(NSString *)value completion:(EZPRequestCompletion)completion;
- (EZPItem *)retrieveItemWithName:(NSString *)name value:(NSString *)value;

@end
