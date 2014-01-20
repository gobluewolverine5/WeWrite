//
//  CITViewController.m
//  WeWrite
//
//  Created by Evan Hsu on 1/16/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import "CITViewController.h"
#import <Collabrify/Collabrify.h>

@interface CITViewController ()

@end

@implementation CITViewController

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
    
    CollabrifyError *error = Nil;
    client = [[CollabrifyClient alloc] initWithGmail:@"evanhsu3@gmail.com" displayName:@"evanhsu3" accountGmail:@"441winter2014@umich.edu" accessToken:@"338692774BBE" error:&error];

    [client setDelegate:self];
    [self setClient:client];
}

- (void)client:(CollabrifyClient *)client encounteredError:(CollabrifyError *)error
{
    
}

- (void)client:(CollabrifyClient *)client receivedEventWithOrderID:(int64_t)orderID submissionRegistrationID:(int32_t)submissionRegistrationID eventType:(NSString *)eventType data:(NSData *)data
{
    
}

- (void)client:(CollabrifyClient *)client receivedBaseFile:(NSData *)baseFile
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
