//
//  ViewController.m
//  Meeting
//
//  Created by SCB on 18/7/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "ViewController.h"
#import "Meeting.h"
#import "AddMeetingViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *meetings;
@property (strong, nonatomic) Meeting *meeting;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    [self.tableVIew reloadData];
}

- (void)fetchMeetings {
    // Fetch Meeting
    self.meetings = [NSMutableArray arrayWithArray:[Meeting findAll]];
}

- (void)fetchSortedMeetings {
    // Fetch Sorted Meetings
    self.meetings = [NSMutableArray arrayWithArray:[Meeting findAllSortedBy:@"name" ascending:YES]];
}

- (void)fetchMeetingsByAttribute:(NSString *)attribute withValue:(id)value {
    self.meetings = [NSMutableArray arrayWithArray:[Meeting findByAttribute:attribute withValue:value]];
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

- (IBAction)edit:(id)sender {
    [self.tableVIew setEditing:![self.tableVIew isEditing] animated:YES];
    if (self.tableVIew.isEditing) {
        [self.editButton setTitle:@"Done"];
    } else {
        [self.editButton setTitle:@"Edit"];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditMeeting"]) {
        AddMeetingViewController *editMeeting = (AddMeetingViewController *)segue.destinationViewController;
        editMeeting.meeting = self.meeting;
    }
}

@end
