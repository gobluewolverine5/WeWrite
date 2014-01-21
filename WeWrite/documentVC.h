//
//  documentVC.h
//  WeWrite
//
//  Created by Evan Hsu on 1/20/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Collabrify/Collabrify.h>

@interface documentVC : UIViewController <UITextViewDelegate, CollabrifyClientDelegate>


@property (strong, nonatomic) IBOutlet UITextView *textbox;
@property (strong, nonatomic) CollabrifyClient *client;
@property (strong, nonatomic) NSArray *tags;


- (IBAction)leaveSession:(id)sender;
- (IBAction)redo:(id)sender;
- (IBAction)undo:(id)sender;
@end
