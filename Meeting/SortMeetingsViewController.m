//
//  SortMeetingsViewController.m
//  Meeting
//
//  Created by SCB on 22/7/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "SortMeetingsViewController.h"
#import "Meeting.h"
#import "ViewController.h"
#import "AddMeetingViewController.h"

@interface SortMeetingsViewController ()
@property (strong, nonatomic) NSMutableArray *meetings;
@property (strong, nonatomic) Meeting *meeting;

@end

@implementation SortMeetingsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Fetch Meetings
    [self fetchSortedMeetings];
    // Reload Table View
    [self.tableView reloadData];
}

- (void)fetchMeetings {
    // Fetch Meeting
    self.meetings = [NSMutableArray arrayWithArray:[Meeting findAll]];
}

- (void)fetchSortedMeetings {
    // Fetch Sorted Meetings
    if (segmentController.selectedSegmentIndex == 0) {
        self.meetings = [NSMutableArray arrayWithArray:[Meeting findAllSortedBy:@"name" ascending:YES]];
    } else if (segmentController.selectedSegmentIndex == 1) {
        self.meetings = [NSMutableArray arrayWithArray:[Meeting findAllSortedBy:@"name" ascending:NO]];
    } else if (segmentController.selectedSegmentIndex == 2) {
        self.meetings = [NSMutableArray arrayWithArray:[Meeting findAllSortedBy:@"department" ascending:YES]];
    }  else if (segmentController.selectedSegmentIndex == 3) {
        self.meetings = [NSMutableArray arrayWithArray:[Meeting findAllSortedBy:@"department" ascending:NO]];
    }
    
}

- (void)fetchMeetingsByAttribute:(NSString *)attribute withValue:(id)value {
    self.meetings = [NSMutableArray arrayWithArray:[Meeting findByAttribute:attribute withValue:value]];
}


-(IBAction)segmentButton:(id)sender {
    if (segmentController.selectedSegmentIndex == 0) {
        self.meetings = [NSMutableArray arrayWithArray:[Meeting findAllSortedBy:@"name" ascending:YES]];
    } else if (segmentController.selectedSegmentIndex == 1) {
        self.meetings = [NSMutableArray arrayWithArray:[Meeting findAllSortedBy:@"name" ascending:NO]];
    } else if (segmentController.selectedSegmentIndex == 2) {
        self.meetings = [NSMutableArray arrayWithArray:[Meeting findAllSortedBy:@"department" ascending:YES]];
    }  else if (segmentController.selectedSegmentIndex == 3) {
        self.meetings = [NSMutableArray arrayWithArray:[Meeting findAllSortedBy:@"department" ascending:NO]];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.meetings count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        // Configure Cell
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    // Fetch Meeting
    Meeting *meeting = [self.meetings objectAtIndex:[indexPath row]];
    // Configure Cell
    [cell.textLabel setText:[meeting name]];
    [cell.detailTextLabel setText:[meeting department]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Fetch Meeting
        Meeting *meeting = [self.meetings objectAtIndex:[indexPath row]];
        // Delete Meeting from Data Source
        [self.meetings removeObjectAtIndex:[indexPath row]];
        // Delete Entity
        [meeting deleteEntity];
        // Update Table View
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Fetch Meeting
    self.meeting = [self.meetings objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditMeeting" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditMeeting"]) {
        AddMeetingViewController *editMeeting = (AddMeetingViewController *)segue.destinationViewController;
        editMeeting.meeting = self.meeting;
    }
}
@end
