//
//  documentVC.h
//  WeWrite
//
//  Created by Evan Hsu on 1/20/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Collabrify/Collabrify.h>

struct event {
    int loc;
    __unsafe_unretained NSMutableString *string;
    
};
@interface documentVC : UIViewController <UITextViewDelegate, CollabrifyClientDelegate> {
    
    NSTimer *track_timer;
}


@property (strong, nonatomic) IBOutlet UITextView *textbox;
@property (strong, nonatomic) CollabrifyClient *client;
@property (strong, nonatomic) NSArray *tags;


- (IBAction)leaveSession:(id)sender;
- (IBAction)redo:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)moveRight:(id)sender;
- (IBAction)moveLeft:(id)sender;

@end
