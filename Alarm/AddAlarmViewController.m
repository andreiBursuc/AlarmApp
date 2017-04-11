//
//  AddAlarmViewController.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "AlarmActionsViewController.h"
#import "MBProgressHUD.h"
#import "APICreateAlarm.h"

@interface AddAlarmViewController ()
{
    IBOutlet UIView *_alarmActionContainerView;
    
}

@property (nonatomic, strong) AlarmActionsViewController *alarmActionVC;

@property (nonatomic, strong) APICreateAlarm *createAlarmRequest;

@end

@implementation AddAlarmViewController

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


#pragma mark - Actions 

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender
{
    [self createAlarm];
}

#pragma mark - Request

-(void)createAlarm
{
    __weak typeof(self) weakSelf = self;

    NSDictionary *params = [self createParams];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _createAlarmRequest = [[APICreateAlarm alloc] init];
    [_createAlarmRequest startRequestWithParams:params andCompletionBlock:^(id response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        if (error) {
            [weakSelf handleCreateAlarmError:error];
        } else {
            [weakSelf handleCreateAlarmResponse:response];
        }
    }];
    
}

-(NSDictionary *)createParams
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self.alarmActionVC.datePicker.date];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSString *stringHour = [NSString stringWithFormat:@"%ld", (long)hour];
    NSString *stringMin = [NSString stringWithFormat:@"%ld", (long)minute];
    
    NSDictionary *params = @{@"label" : @"Alarm", @"hour" : stringHour, @"minutes": stringMin, @"enabled" : @"true"};
    
    return params;
}

-(void)handleCreateAlarmResponse:(NSDictionary *)response
{
    AlarmVO *alarm = [[AlarmVO alloc] initWithDictionary:response];
    if ([self.delegate respondsToSelector:@selector(addAlarmVC:didSaveAlarm:)]) {
        [self.delegate addAlarmVC:self didSaveAlarm:alarm];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)handleCreateAlarmError:(NSError *)error
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
