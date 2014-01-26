//
//  eventElement.m
//  WeWrite
//
//  Created by Evan Hsu on 1/26/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import "eventElement.h"

@implementation eventElement {
    int location;
}

@synthesize submission_id;
@synthesize order_id;
@synthesize insert;
@synthesize string;

- (id) init
{
    if (self = [super init]) {
        order_id = -1;
        location = -1;
        string = [[NSMutableString alloc] init];
    }
    return self;
}

- (void) updateLocation:(int)value
{
    location = value;
}

- (int)getLocation
{
    return location;
}
@end
