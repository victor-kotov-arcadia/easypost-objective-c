
// Created by Sinisa Drpa, 2015.

#import "EZPAddress.h"
#import "EZPRequest.h"

#import "AFNetworking.h"

@interface EZPAddress ()
@end

@implementation EZPAddress

// Fix an error when trying to set the value of a BOOL to nil.
-(void)setNilValueForKey:(NSString *)key{
    if([key isEqualToString:@"residential"]){
        self.residential = NO;
    } else {
        [super setNilValueForKey:key];
    }
}

@end
