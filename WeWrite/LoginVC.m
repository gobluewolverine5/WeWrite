//
//  LoginVC.m
//  WeWrite
//
//  Created by Evan Hsu on 1/20/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import "LoginVC.h"
#import "newSessionVC.h"
#import "joinSessionVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

@synthesize gmail_textfield;
@synthesize username_textfield;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toNewSession"]) {
        newSessionVC *new_session = (newSessionVC *) segue.destinationViewController;
        new_session.gmail       = gmail_textfield.text;
        new_session.username    = username_textfield.text;
        
    } else if ([segue.identifier isEqualToString:@"toJoinSession"]) {
        joinSessionVC *join_session = (joinSessionVC *) segue.destinationViewController;
        join_session.gmail      = gmail_textfield.text;
        join_session.username   = username_textfield.text;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    gmail_textfield.delegate = self;
    username_textfield.delegate = self;
    [gmail_textfield setReturnKeyType:UIReturnKeyNext];
    [username_textfield setReturnKeyType:UIReturnKeyDone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == gmail_textfield) {
        [username_textfield becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}
- (IBAction)newSession:(id)sender {
    [self performSegueWithIdentifier:@"toNewSession" sender:Nil];
}

- (IBAction)joinSession:(id)sender {
    [self performSegueWithIdentifier:@"toJoinSession" sender:Nil];
}
@end
