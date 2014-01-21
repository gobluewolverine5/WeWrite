//
//  joinSessionVC.h
//  WeWrite
//
//  Created by Evan Hsu on 1/20/14.
//  Copyright (c) 2014 EECS 441. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Collabrify/Collabrify.h>

@interface joinSessionVC : UIViewController <UITableViewDataSource,
                                                UITableViewDelegate,
                                                CollabrifyClientDelegate,
                                                UITextFieldDelegate>{
    NSString *gmail;
    NSString *username;
}

@property (nonatomic, retain) NSString *gmail;
@property (nonatomic, retain) NSString *username;

@property (strong, nonatomic) CollabrifyClient *client;
@property (strong, nonatomic) NSArray *tags;

@property (strong, nonatomic) IBOutlet UITableView *sessions_table;
@property (strong, nonatomic) IBOutlet UITextField *session_password;

- (IBAction)joinSession:(id)sender;
@end
