//
//  AddMeetingViewController.h
//  Meeting
//
//  Created by SCB on 18/7/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Meeting;

@interface AddMeetingViewController : UITableViewController


@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *positionField;
@property (strong, nonatomic) IBOutlet UITextField *departmentField;
@property (strong, nonatomic) IBOutlet UITextField *contentField;

@property (strong, nonatomic) Meeting *meeting;

- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;

@end
