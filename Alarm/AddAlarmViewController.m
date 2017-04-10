//
//  AddAlarmViewController.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "AlarmActionsViewController.h"

@interface AddAlarmViewController ()
{
    IBOutlet UIView *_alarmActionContainerView;
    
}
@end

@implementation AddAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
}

#pragma mark - Utils

-(void)initialSetup
{
    AlarmActionsViewController *alarmActionVC = [[AlarmActionsViewController alloc] init];
    [alarmActionVC.view setFrame:_alarmActionContainerView.frame];
    [_alarmActionContainerView addSubview:alarmActionVC.view];
}

#pragma mark - Actions 

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
