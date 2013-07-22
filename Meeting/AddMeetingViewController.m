//
//  AddMeetingViewController.m
//  Meeting
//
//  Created by SCB on 18/7/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "AddMeetingViewController.h"
#import "Meeting.h"

@interface AddMeetingViewController ()
@property (nonatomic) BOOL isEditing;

@end

@implementation AddMeetingViewController
@synthesize nameField = _nameField;
@synthesize positionField = _positionField;
@synthesize departmentField = _departmentField;
@synthesize contentField = _contentField;


- (IBAction)backgroundTouched:(id)sender {
    [_nameField resignFirstResponder];
    [_positionField resignFirstResponder];
    [_departmentField resignFirstResponder];
    [_contentField resignFirstResponder];
}
- (IBAction)textfieldReturn:(id)sender {
    [sender resignFirstResponder];
}

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
    self.isEditing = NO;
    if (self.meeting) {
        // Populate Form Fields
        [self.nameField setText:[self.meeting name]];
        [self.positionField setText:[self.meeting position]];
        [self.departmentField setText:[self.meeting department]];
        [self.contentField setText:[self.meeting content]];
        self.isEditing = YES;
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonClicked:(id)sender {
    if (!self.meeting) {
        // Create meeting
        self.meeting = [Meeting createEntity];
        // Configure Meeting
        [self.meeting setDate:[NSDate date]];
    }
    // Configure Note
    [self.meeting setName:[self.nameField text]];
    [self.meeting setPosition:[self.positionField text]];
    [self.meeting setDepartment:[self.departmentField text]];
    [self.meeting setContent:[self.contentField text]];
    // Save Managed Object Context
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
    //[[NSManagedObjectContext defaultContext] saveNestedContexts];
    if (self.isEditing) {
        // Pop View Controller from Navigation Stack
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        // Dismiss View Controller
        [self dismissViewControllerAnimated:YES completion:nil];
    }

} 
@end
