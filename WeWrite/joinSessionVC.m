//
//  joinSessionVC.m
//  WeWrite
//
//  Created by Evan Hsu on 1/20/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import "joinSessionVC.h"
#import "documentVC.h"
#import <Collabrify/Collabrify.h>

@interface joinSessionVC ()

@end

@implementation joinSessionVC {
    NSArray *session_list;
    int64_t selectedSessionID;
}

@synthesize gmail;
@synthesize username;

@synthesize client;
@synthesize tags;

@synthesize sessions_table;
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

    client = [[CollabrifyClient alloc]  initWithGmail:gmail
                                          displayName:username
                                         accountGmail:@"441winter2014@umich.edu"
                                          accessToken:@"338692774BBE"
                                                error:Nil];
    [client setDelegate:self];
    [self setClient:client];
    [self setTags:@[@"ESA"]];
    
    sessions_table.delegate = self;
    sessions_table.dataSource = self;
    
    session_list = [[NSArray alloc]init];
    selectedSessionID = -1;
    
    session_password.delegate = self;
    [session_password setReturnKeyType:UIReturnKeyGo];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    //Getting all sessions with the same tags (ESA tags)
    [[self client] listSessionsWithTags:[self tags] completionHandler:^(NSArray *sessions, CollabrifyError *error) {
        if (error) NSLog(@"Error = %@", error);
        
        session_list = sessions;
        [sessions_table reloadData]; //Refreshing UITableView with all active sessions
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"joinSessionToDocument"]) {
        documentVC *document = (documentVC *) segue.destinationViewController;
        document.client = client;
        document.tags   = tags;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == session_password) {
        [self join];
        [textField resignFirstResponder];
    }
    return YES;
}

/************** Start Client Code Block **************/
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
/************** End Client Code Block **************/

- (void) join
{
    if (selectedSessionID != -1) {
        NSLog(@"selectedSessionID = %lld", selectedSessionID);
        [[self client] joinSessionWithID:selectedSessionID password:session_password.text startPaused:NO completionHandler:^(int64_t maxOrderID, int32_t baseFileSize, CollabrifyError *error) {
            if (!error)
            {
                //update your interface;
                [self performSegueWithIdentifier:@"joinSessionToDocument"
                                          sender:Nil];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle     :@"Error"
                                      message           :@"There was an Error"
                                      delegate          :nil
                                      cancelButtonTitle :@"OK"
                                      otherButtonTitles :nil];
                [alert show];
            }
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle     :@"Error"
                              message           :@"Please Select a Session"
                              delegate          :nil
                              cancelButtonTitle :@"OK"
                              otherButtonTitles :nil];
        [alert show];
    }
}

- (IBAction)joinSession:(id)sender
{
    [self join];
}



#pragma mark - Table view data source

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedSessionID = [[session_list objectAtIndex:indexPath.row] sessionID];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [session_list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle   :UITableViewCellStyleDefault
                reuseIdentifier :CellIdentifier];
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    NSArray *components = [[[session_list objectAtIndex:indexPath.row]sessionName] componentsSeparatedByString:@"ESA"];
    cell.textLabel.text = [components objectAtIndex:0];
    
    return cell;
}

@end
