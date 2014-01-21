//
//  LoginVC.h
//  WeWrite
//
//  Created by Evan Hsu on 1/20/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *gmail_textfield;
@property (strong, nonatomic) IBOutlet UITextField *username_textfield;

- (IBAction)newSession:(id)sender;
- (IBAction)joinSession:(id)sender;
@end
