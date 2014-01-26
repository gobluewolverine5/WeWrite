//
//  documentVC.m
//  WeWrite
//
//  Created by Evan Hsu on 1/20/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import "documentVC.h"
#import "deque.h"
#import "eventElement.h"

@interface documentVC ()

@end

@implementation documentVC {
    NSUndoManager *myUndoManager;
    NSTimeInterval *event_interval;
    NSMutableString *buffer;
    int location;
    deque *localUndoEvents;
    deque *localRedoEvents;
    BOOL inserted;
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
   
    /*
    [client setDelegate:self];
    [self setClient:client];
     */
    
    textbox.delegate = self;
    textbox.text = @"";
    textbox.autocorrectionType = UITextAutocorrectionTypeNo;
    textbox.userInteractionEnabled = NO;
   
    /*
    myUndoManager = [[NSUndoManager alloc]init];
    myUndoManager = [textbox undoManager];
    */
    
    track_timer = [NSTimer scheduledTimerWithTimeInterval:2
                                                   target:self
                                                 selector:@selector(addEvent)
                                                 userInfo:Nil
                                                  repeats:YES];
    buffer = [[NSMutableString alloc] init];
    localUndoEvents = [[deque alloc] init];
    localRedoEvents = [[deque alloc] init];
    inserted = TRUE;
    
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

- (BOOL)canBecomeFirstResponder
{
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *parameter_string = @"";
    parameter_string = [[textView text] stringByAppendingString:text];
    
    location =  [textView offsetFromPosition:0
                                  toPosition:textView.selectedTextRange.start];
   
    //NSLog(@"location: %i", location);
    
    
    // Inserting Operation
    if (![text isEqualToString:@""]) {
        if (!inserted) {
            [self pushEvent:buffer cursorLocation:location typeEvent:inserted];
        }
        [buffer appendString:text];
        inserted = TRUE;
    }
    // Delete Operation
    else {
        if (inserted) {
            [self pushEvent:buffer cursorLocation:location typeEvent:inserted];
        }
        [buffer insertString:[[textView text] substringWithRange:range] atIndex:0];
        inserted = FALSE;
        
    }
   
    /*
    NSLog(@"replacement text: %@", text);
    NSLog(@"parameter: %@", parameter_string);
    NSLog(@"buffer: %@", buffer);
    NSLog(@"textView: %@", [textView text]);
    NSLog(@"range lenth: %lu", (unsigned long)range.length);
    
    NSLog(@"range position: %lu", (unsigned long)range.location);
     */
    
    return YES;
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

- (void) addEvent
{
    
    [self pushEvent:buffer cursorLocation:location typeEvent:inserted];
    NSLog(@"Auto add event called");
}

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
    //[myUndoManager redo];
}

- (IBAction)undo:(id)sender {
    //[myUndoManager undo];
    if ([localUndoEvents size] == 0) {
        return;
    }
    eventElement *temp = [localUndoEvents popFront];
    NSLog(@"location: %i", [temp getLocation]);
    NSLog(@"size of undo stack: %i", [localUndoEvents size]);
    if (temp.insert) {
        NSRange tempRange;
        
        // +1 to fix location
        tempRange.location = [temp getLocation] - [temp.string length] + 1;
        tempRange.length = [temp.string length];
        [textbox setText:[textbox.text stringByReplacingCharactersInRange:tempRange withString:@""]];
    } else {
        NSRange tempRange;
        tempRange.location = [temp getLocation];
        tempRange.length = [temp.string length];
        [self insertString:temp.string insertRange:tempRange];
    }
    [localRedoEvents pushFront:temp];
}

- (IBAction)moveRight:(id)sender {
   
    location = 1 + [textbox offsetFromPosition:0
                                     toPosition:textbox.selectedTextRange.start];
    textbox.selectedRange = NSMakeRange(location, 0);
    
    [self pushEvent:buffer cursorLocation:location typeEvent:inserted];
}

- (IBAction)moveLeft:(id)sender {
   
    if (location) {
        location = -1 + [textbox offsetFromPosition:0
                                     toPosition:textbox.selectedTextRange.start];
        
        [self pushEvent:buffer cursorLocation:location typeEvent:inserted];
        
    }
    textbox.selectedRange = NSMakeRange(location, 0);
}

- (void) pushEvent:(NSMutableString*)string cursorLocation:(int)loc typeEvent:(BOOL)type
{
    // broadcast message and obtain registration id
    if (![buffer isEqualToString:@""]) {
        eventElement *temp = [[eventElement alloc] init];
        [temp setString:[NSMutableString stringWithFormat:@"%@", buffer]];
        [temp updateLocation:loc];
        [temp setInsert:type];
        
        if ([localUndoEvents size] > 20) [localUndoEvents popBack];
        [localUndoEvents pushFront:temp];
        
        [buffer setString:@""];
    }
}

- (void) insertString:(NSString *)insertingString insertRange:(NSRange)range
{
    NSString * firstHalfString = [textbox.text substringToIndex:range.location];
    NSString * secondHalfString = [textbox.text substringFromIndex: range.location];
    textbox.scrollEnabled = NO;  // turn off scrolling or you'll get dizzy ... I promise
    
    textbox.text = [NSString stringWithFormat: @"%@%@%@",
                     firstHalfString,
                     insertingString,
                     secondHalfString];
    range.location += [insertingString length];
    textbox.selectedRange = range;
    textbox.scrollEnabled = YES;  // turn scrolling back on.
    
}
@end
