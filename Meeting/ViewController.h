//
//  ViewController.h
//  Meeting
//
//  Created by SCB on 18/7/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableVIew;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (IBAction)edit:(id)sender;

@end
