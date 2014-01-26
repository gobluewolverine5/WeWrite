//
//  deque.h
//  WeWrite
//
//  Created by Evan Hsu on 1/26/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface deque : NSObject

- (void) pushFront:(id)element;
- (id) popFront;
- (id) popBack;
- (void) pushBack:(id)element;
- (int) size;

@end
