//
//  newSessionVC.m
//  WeWrite
//
//  Created by Evan Hsu on 1/20/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import "newSessionVC.h"
#import "documentVC.h"
#import <Collabrify/Collabrify.h>

@interface newSessionVC ()

@end

@implementation newSessionVC {}

@synthesize gmail;
@synthesize username;

@synthesize client;
@synthesize tags;

@synthesize session_name;
@synthesize session_password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setClient:client];
    client.delegate = self;
    [self setTags:@[@"ESA"]];
    client = [[CollabrifyClient alloc] initWithGmail:gmail
                                         displayName:username
                                        accountGmail:@"441winter2014@umich.edu"
                                         accessToken:@"338692774BBE"
                                               error:nil];
   
    
    
    session_name.delegate = self;
    session_password.delegate = self;
    [session_name setReturnKeyType:UIReturnKeyNext];
    [session_password setReturnKeyType:UIReturnKeyGo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == session_name) {
        [session_password becomeFirstResponder];
    } else if (textField == session_password) {
        [textField resignFirstResponder];
        [self create];
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"createSessionToDocument"]) {
        //pass variables
        documentVC *document = (documentVC *)segue.destinationViewController;
        document.client = client;
        document.tags   = tags;
    }
}


#pragma Encountered Error
- (void)client:(CollabrifyClient *)client encounteredError:(CollabrifyError *)error
{
    NSLog(@"Error was encountered");
    if ([[error domain] isEqualToString:CollabrifyClientSideErrorDomain])
    {
        if ([error type] == CollabrifyClientSideErrorCannotConnectToCollabrify)
        {
            //There is no internet
            if ([error isKindOfClass:[CollabrifyUnrecoverableError class]])
            {
                //reset your interface
            }
        }
    }
}

- (void)client:(CollabrifyClient *)client receivedEventWithOrderID:(int64_t)orderID submissionRegistrationID:(int32_t)submissionRegistrationID eventType:(NSString *)eventType data:(NSData *)data
{
    
}

- (void)client:(CollabrifyClient *)client receivedBaseFile:(NSData *)baseFile
{
    
}

#pragma Session Ended
- (void) client:(CollabrifyClient *)client sessionEnded:(int64_t)sessionID
{
    NSLog(@"Session ID: %lld has ended", sessionID);
}

#pragma Client Joined
- (void) client:(CollabrifyClient *)client participantJoined:(CollabrifyParticipant *)participant
{
    NSLog(@"Participant %@ has joined", participant.displayName);
}

#pragma Client Left
- (void) client:(CollabrifyClient *)client participantLeft:(CollabrifyParticipant *)participant
{
    NSLog(@"Participant %@ has left", participant.displayName);
}

- (void) create
{
    
    if ([session_name.text isEqualToString:@""]) { //Empty Session Name
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle     :@"Error"
                              message           :@"Please Enter a Session Name"
                              delegate          :nil
                              cancelButtonTitle :@"OK"
                              otherButtonTitles :nil];
        [alert show];
        
    } else {
        
        //Creating session with client object
        NSInteger randomNumber  = arc4random_uniform(9999);
        NSString *sessionName   = [NSString stringWithFormat:@"%@ESA%ld", session_name.text, (long)randomNumber];
        
        NSLog(@"Session Name: %@", sessionName);
        NSLog(@"Session Password: %@", session_password.text);
        
        [[self client] createSessionWithName:sessionName password:session_password.text
                                        tags:[self tags]    startPaused:NO
                           completionHandler:^(int64_t sessionID, CollabrifyError *error) {
            if (!error) {
                NSLog(@"Successful");
                [self performSegueWithIdentifier:@"createSessionToDocument"
                                          sender:Nil];
            }
            else {
                NSLog(@"Error Creating Session = %@", error);
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle     :@"Error"
                                      message           :@"An Error Occured"
                                      delegate          :nil
                                      cancelButtonTitle :@"OK"
                                      otherButtonTitles :nil];
                [alert show];
            }
        }];
    }
}
- (IBAction)createSession:(id)sender
{
    [self create];
}
@end
