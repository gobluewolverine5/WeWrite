//
//  eventElement.h
//  WeWrite
//
//  Created by Evan Hsu on 1/26/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eventElement : NSObject

@property (nonatomic) int submission_id;
@property (nonatomic) int64_t order_id;
@property (nonatomic) BOOL insert;
@property (strong, retain) NSMutableString *string;

- (void) updateLocation:(int)value;
- (void) updateSubmission:(int)value;
- (int) getLocation;
- (int) getSubmission;

@end
