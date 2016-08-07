//
//  EZPClient+Container.h
//  EasyPost
//
//  Created by Dmitry Rodionov on 05/08/16.
//  Copyright © 2016 Tagtaxa. All rights reserved.
//

#import "EZPClient.h"
#import "EZPContainer.h"

@interface EZPClient (Container)

/**
 * Retrieve a Container from its id or reference
 */
- (void)retrieveContainer:(NSString *)itemId completion:(EZPRequestCompletion)completion;
- (EZPContainer *)retrieveContainer:(NSString *)itemId;
/**
 * Create a Container
 */
- (void)createContainerWithParameters:(NSDictionary *)parameters completion:(EZPRequestCompletion)completion;
- (EZPContainer *)createContainerWithParameters:(NSDictionary *)parameters;

@end
