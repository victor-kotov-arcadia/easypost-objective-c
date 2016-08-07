//
//  EZPClient+CarrierType.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPCarrierType.h"

@interface EZPClient (CarrierType)

/**
 * Get list of carrier types
 * REQUIRES kLiveSecretAPIKey
 */
- (void)listCarrierTypes:(EZPRequestCompletion)completion;
- (NSArray *)listOfCarrierTypes;

@end
