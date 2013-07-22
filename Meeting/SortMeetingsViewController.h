//
//  SortMeetingsViewController.h
//  Meeting
//
//  Created by SCB on 22/7/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortMeetingsViewController : UIViewController {
    IBOutlet UISegmentedControl *segmentController;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchField;

-(IBAction)segmentButton:(id)sender;

@end
