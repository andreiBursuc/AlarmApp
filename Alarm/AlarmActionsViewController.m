//
//  AlarmActionsViewController.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "AlarmActionsViewController.h"

@interface AlarmActionsViewController ()
{
    IBOutlet UIDatePicker *_datePicker;
    
}
@end

@implementation AlarmActionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initialSetup];
}

#pragma mark - Utils

-(void)initialSetup
{
    [_datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
}

@end
