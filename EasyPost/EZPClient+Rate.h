//
//  EZPClient+Rate.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPRate.h"

@interface EZPClient (Rate)
/**
 * Retrieve a Rate from its id
 */
- (void)retrieveRate:(NSString *)rateId completion:(EZPRequestCompletion)completion;
- (EZPRate *)retrieveRate:(NSString *)rateId;

@end
