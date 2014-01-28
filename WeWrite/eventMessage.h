//
//  eventMessage.h
//  WeWrite
//
//  Created by Evan Hsu on 1/28/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eventMessage : NSObject

- (NSData*) formEvent:(int)type eventText:(NSString*)string eventCursor:(double)cursor;
- (NSMutableDictionary*) retrieveEvent:(NSData*)data;

@end
