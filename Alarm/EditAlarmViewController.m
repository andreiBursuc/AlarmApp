//
//  EditAlarmViewController.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/11/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "EditAlarmViewController.h"
#import "AlarmActionsViewController.h"
#import "MBProgressHUD.h"
#import "EditAlarmRequestManager.h"

@interface EditAlarmViewController ()<EditAlarmRequestManagerDelegate>
{
    IBOutlet UIView *_alarmActionContainerView;
}

@property (nonatomic, strong) AlarmActionsViewController *alarmActionVC;
@property (nonatomic, strong) EditAlarmRequestManager *editRequestManager;

@end

@implementation EditAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
}

#pragma mark - Utils

-(void)initialSetup
{
    _alarmActionVC = [[AlarmActionsViewController alloc] init];
    [_alarmActionVC.view setFrame:_alarmActionContainerView.frame];
    [_alarmActionContainerView addSubview:_alarmActionVC.view];
}

#pragma mark - EditAlarmRequestManagerDelegate

-(void)editAlarmManagerDidFinishRequestWithResponse:(NSDictionary *)response
{
    [self hideProgressHUD];
    
    AlarmVO *editedAlarm = [[AlarmVO alloc] initWithDictionary:response];
    
    if ([self.delegate respondsToSelector:@selector(editAlarmViewControllerDidEditAlarm:)]) {
        [self.delegate editAlarmViewControllerDidEditAlarm:editedAlarm];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)editAlarmManagerDidFinishRequestWithError:(NSError *)error
{
    [self hideProgressHUD];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender
{
    [self startEditAlarmRequest];
}

#pragma mark - Requests

-(void)startEditAlarmRequest
{
    _editRequestManager = [[EditAlarmRequestManager alloc] init];
    _editRequestManager.delegate = self;
    _editRequestManager.alarm = self.alarm;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [_editRequestManager startRequestWithParams:[self createParams]];
}

-(NSDictionary *)createParams
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self.alarmActionVC.datePicker.date];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSString *stringHour = [NSString stringWithFormat:@"%ld", (long)hour];
    NSString *stringMin = [NSString stringWithFormat:@"%ld", (long)minute];
    
    NSString *enabledFlag = _alarm.enabled ? @"true" : @"false";
    
    NSDictionary *params = @{@"label" : _alarm.alarmLabel, @"hour" : stringHour, @"minutes": stringMin, @"enabled" : enabledFlag};
    
    return params;
}

-(void)hideProgressHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

@end
