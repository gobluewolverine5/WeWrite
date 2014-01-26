//
//  deque.m
//  WeWrite
//
//  Created by Evan Hsu on 1/26/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import "deque.h"

@implementation deque {
    NSMutableArray *array;
}

- (id) init
{
    if (self = [super init]) {
        array = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void) pushFront:(id) element
{
    //Pushing to the end of the array
    [array addObject:element];
}

- (id) popFront
{
    id item = nil;
    if ([array count]) {
        item = [array lastObject];
        [array removeLastObject];
    }
    return item;
}

- (id) popBack
{
    id item = nil;
    if ([array count]) {
        item = [array objectAtIndex:0];
        [array removeObjectAtIndex:0];
    }
    return item;
}

- (void) pushBack:(id)element
{
    [array insertObject:element atIndex:0];
}

- (int) size
{
    return [array count];
}


@end
