
// Created by Sinisa Drpa, 2015.

#import "EZPParcel.h"
#import "EZPRequest.h"

#import "AFNetworking.h"

@implementation EZPParcel

-(void)setNilValueForKey:(NSString *)key{    
    if ([key isEqualToString:@"height"]) {
        [self setValue:[NSNumber numberWithFloat:0.0] forKey:@"height"];
    } else if ([key isEqualToString:@"width"]) {
        [self setValue:[NSNumber numberWithFloat:0.0] forKey:@"width"];
    } else if ([key isEqualToString:@"length"]) {
        [self setValue:[NSNumber numberWithFloat:0.0] forKey:@"length"];
    } else {
        [super setNilValueForKey:key];
    }
}

@end
