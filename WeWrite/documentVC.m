//
//  documentVC.m
//  WeWrite
//
//  Created by Evan Hsu on 1/20/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import "documentVC.h"

@interface documentVC ()

@end

@implementation documentVC {
    NSUndoManager *myUndoManager;
}

@synthesize textbox;

@synthesize tags;
@synthesize client;

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
   
    NSLog(@"documentVC Loaded");
    
    [client setDelegate:self];
    [self setClient:client];
    
    textbox.delegate = self;
    textbox.text = @"";
    
    myUndoManager = [[NSUndoManager alloc]init];
    myUndoManager = [textbox undoManager];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [textbox becomeFirstResponder];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[self client] leaveAndEndSession:TRUE completionHandler:^(BOOL success, CollabrifyError *error) {
        NSLog(@"leave session is called");
        if (success) {
            
            NSLog(@"leaving session was successful");
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"Error Leaving Session: %@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/************* Start Client Code Block ************/
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
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle     :@"Done"
                          message           :@"Session Has Ended"
                          delegate          :nil
                          cancelButtonTitle :@"OK"
                          otherButtonTitles :nil];
    [alert show];
    [self.navigationController popViewControllerAnimated:YES];
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
/************* End Client Code Block ************/

- (IBAction)leaveSession:(id)sender {
    
    [[self client] leaveAndEndSession:TRUE completionHandler:^(BOOL success, CollabrifyError *error) {
        NSLog(@"leave session is called");
        if (success) {
            
            NSLog(@"leaving session was successful");
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"Error Leaving Session: %@", error);
        }
    }];
}

- (IBAction)redo:(id)sender {
    [myUndoManager redo];
}

- (IBAction)undo:(id)sender {
    [myUndoManager undo];
}
@end
