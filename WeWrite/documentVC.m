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
#import "eventMessage.h"

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
    eventMessage *event_message;
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
    
    event_message = [[eventMessage alloc] init];
    
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
    
    //NSLog(@"location: %i", location);
    
    // Inserting Operation
    if (![text isEqualToString:@""]) {
        if (!inserted) {
            [self pushEvent:buffer typeEvent:inserted];
        }
        [buffer appendString:text];
        inserted = TRUE;
    }
    // Delete Operation
    else {
        if (inserted) {
            [self pushEvent:buffer typeEvent:inserted];
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

- (int) broadcastEvent:(NSString*)message typeEvent:(BOOL)type cursorLocation:(int)loc
{
    NSData *send_data =[event_message formEvent:((type)? 0:1)
                                      eventText:message
                                    eventCursor:(double)loc];
    int registration_id = [[self client] broadcast:send_data eventType:@"eventMessage"];
    NSLog(@"Sent Message with registration id: %i", registration_id);
    return registration_id;
}

#pragma Client Retrieve Data
- (void)client:(CollabrifyClient *)client receivedEventWithOrderID:(int64_t)orderID submissionRegistrationID:(int32_t)submissionRegistrationID eventType:(NSString *)eventType data:(NSData *)data
{
    NSMutableDictionary *received_data = [event_message retrieveEvent:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //[[self statusLabel] setText:chatMessage];
        NSLog(@"order_id %lli", orderID);
        NSLog(@"registration id: %i", submissionRegistrationID);
        NSLog(@"received_data: %@", received_data);
        
        
    });
}


/************* End Client Code Block ************/


/************* IBAction Code ****************/

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
   
    //Return if there is nothing to redo
    if ([localRedoEvents size] == 0) return;
    
    eventElement *temp = [localRedoEvents popFront];
    [self eventHandle:temp];
    [localUndoEvents pushFront:temp];
}

- (IBAction)undo:(id)sender {
    
    //Return if there is nothing to undo
    if ([localUndoEvents size] == 0) return;
    
    eventElement *temp = [localUndoEvents popFront];
    [self eventHandle:temp];
    [localRedoEvents pushFront:temp];
}



- (IBAction)moveRight:(id)sender {
   
    location = 1 + [textbox offsetFromPosition:0
                                     toPosition:textbox.selectedTextRange.start];
    textbox.selectedRange = NSMakeRange(location, 0);
    
    [self pushEvent:buffer typeEvent:inserted];
}

- (IBAction)moveLeft:(id)sender {
   
    if (location) {
        location = -1 + [textbox offsetFromPosition:0
                                     toPosition:textbox.selectedTextRange.start];
        
        [self pushEvent:buffer typeEvent:inserted];
        
    }
    textbox.selectedRange = NSMakeRange(location, 0);
}

/************* End IBAction Code ****************/

- (void) pushEvent:(NSMutableString*)string typeEvent:(BOOL)type
{
    [self stopTimer];
    location =  [textbox offsetFromPosition:0
                                  toPosition:textbox.selectedTextRange.start];
    
    // broadcast message and obtain registration id
    if (![buffer isEqualToString:@""]) {
        
        int reg_id = [self broadcastEvent:[NSString stringWithFormat:@"%@", buffer]
                   typeEvent:type
              cursorLocation:location];
        
        eventElement *temp = [[eventElement alloc] init];
        [temp setString:[NSMutableString stringWithFormat:@"%@", buffer]];
        [temp updateLocation:location];
        [temp setInsert:type];
        [temp setSubmission_id:reg_id];
        [temp setOrder_id:-1];
       
        if ([localUndoEvents size] > 20) [localUndoEvents popBack];
        [localUndoEvents pushFront:temp];
        
        [buffer setString:@""];
    }
    [self startTimer];
}

- (void) insertString:(NSString *)insertingString insertRange:(NSRange)range
{
    
    textbox.scrollEnabled = NO;  // turn off scrolling or you'll get dizzy ... I promise
    if ([textbox.text length] == 0) {
        [textbox setText:[NSString stringWithFormat:@"%@", insertingString]];
    } else {
        
        NSString * firstHalfString = [textbox.text substringToIndex:range.location];
        NSString * secondHalfString = [textbox.text substringFromIndex: range.location];
       
        textbox.text = [NSString stringWithFormat: @"%@%@%@",
                         firstHalfString,
                         insertingString,
                         secondHalfString];
        range.location += [insertingString length];
        textbox.selectedRange = range;
    }
    textbox.scrollEnabled = YES;  // turn scrolling back on.
}

- (void) eventHandle:(eventElement*)event
{
    NSLog(@"location: %i", [event getLocation]);
    NSLog(@"size of undo stack: %i", [localUndoEvents size]);
    
    //Reverting Insert Event
    if (event.insert) {
        NSRange tempRange;
        
        // +1 to fix location
        tempRange.location = [event getLocation] - [event.string length];
        tempRange.length = [event.string length];
        [textbox setText:[textbox.text stringByReplacingCharactersInRange:tempRange withString:@""]];
        
        [event updateLocation:tempRange.location];
    }
    //Reverting Delete Event
    else {
        NSRange tempRange;
        tempRange.location = [event getLocation];
        tempRange.length = [event.string length];
        [self insertString:event.string insertRange:tempRange];
        
        [event updateLocation:(tempRange.location + tempRange.length)];
    }
    event.insert = !event.insert;
}




/**************** Start Timer Code *****************/

- (void) stopTimer
{
    [track_timer invalidate];
    track_timer = Nil;
}

- (void) startTimer
{
    track_timer = [NSTimer scheduledTimerWithTimeInterval:2
                                                   target:self
                                                 selector:@selector(addEvent)
                                                 userInfo:Nil
                                                  repeats:YES];
}

- (void) addEvent
{
    [self pushEvent:buffer typeEvent:inserted];
    //NSLog(@"Auto add event called");
}

/**************************************************/

@end
