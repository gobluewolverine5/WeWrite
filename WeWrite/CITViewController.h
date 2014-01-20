//
//  CITViewController.h
//  WeWrite
//
//  Created by Evan Hsu on 1/16/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Collabrify/Collabrify.h>

@interface CITViewController : UIViewController <CollabrifyClientDelegate>

@property (strong, nonatomic) CollabrifyClient *client;

- (void)client:(CollabrifyClient *)client encounteredError:(CollabrifyError *)error;
- (void)client:(CollabrifyClient *)client receivedEventWithOrderID:(int64_t)orderID submissionRegistrationID:(int32_t)submissionRegistrationID eventType:(NSString *)eventType data:(NSData *)data;
- (void)client:(CollabrifyClient *)client receivedBaseFile:(NSData *)baseFile;

@end
