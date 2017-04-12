//
//  AlarmViewController.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "AlarmViewController.h"
#import "AlarmTableViewCell.h"
#import "APIGetAlarms.h"
#import "MBProgressHUD.h"
#import "AddAlarmViewController.h"
#import "EditAlarmViewController.h"
#import "DeleteAlarmRequestManager.h"
#import "EditAlarmRequestManager.h"

@interface AlarmViewController ()<UITableViewDelegate, UITableViewDataSource,AddAlarmViewControllerDelegate, EditAlarmViewControllerDelegate,DeleteAlarmRequestManagerDelegate, EditAlarmRequestManagerDelegate, AlarmTableViewCellDelegate>
{
    IBOutlet UITableView *_tableView;
    IBOutlet UIBarButtonItem *_editButton;
    
    NSMutableArray * _alarmsMuttableArray;
    AlarmVO *deletedAlarm;
}

@property(nonatomic, strong) APIGetAlarms* getAlarmsRequest;
@property(nonatomic, strong) DeleteAlarmRequestManager *deleteAlarmRequestManager;
@property(nonatomic, strong) EditAlarmRequestManager *editRequestManager;


@end

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
    [self startGetAlarmsRequest];
}

#pragma mark - Initial Setup

-(void)initialSetup
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
      @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [_tableView registerNib:[UINib nibWithNibName:@"AlarmTableViewCell" bundle:nil]forCellReuseIdentifier:@"AlarmTableViewCell"];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddAlarmViewController *addAlarmVC = (AddAlarmViewController *)segue.destinationViewController;
    addAlarmVC.delegate = self;
}

#pragma mark - EditAlarmViewControllerDelegate

-(void)editAlarmViewControllerDidEditAlarm:(AlarmVO *)alarm
{
    for (AlarmVO *alarmVO in _alarmsMuttableArray) {
        if (alarmVO.alarmID == alarm.alarmID) {
            NSInteger index = [_alarmsMuttableArray indexOfObject:alarmVO];
            [_alarmsMuttableArray replaceObjectAtIndex:index withObject:alarm];
            [_tableView reloadData];
            break;
        }
    }
}

#pragma mark - AddAlarmViewControllerDelegate

-(void)addAlarmVC:(AddAlarmViewController *)viewController didSaveAlarm:(AlarmVO *)alarm
{
    [_alarmsMuttableArray addObject:alarm];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _alarmsMuttableArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmTableViewCell"];
    
    cell.delegate = self;
    
    cell.accessoryType = tableView.isEditing ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    
    [cell setupWithAlarm:_alarmsMuttableArray[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (tableView.editing == NO) {
        return;
    }
    
    AlarmVO *selectedAlarm = _alarmsMuttableArray[indexPath.row];
    
    EditAlarmViewController *editAlarmVC = (EditAlarmViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"EditAlarmViewController"];
    editAlarmVC.alarm = selectedAlarm;
    editAlarmVC.delegate = self;
    
    [self presentViewController:editAlarmVC animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      
        [self startDeleteAlarmRequest:_alarmsMuttableArray[indexPath.row]];
    }
}

#pragma mark - AlarmTableViewCellDelegate

-(void)alarmTableViewCell:(AlarmTableViewCell *)cell didChangeAlarmState:(BOOL)state
{
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
    
    AlarmVO *alarm = _alarmsMuttableArray[indexPath.row];
    alarm.enabled = state;
    
    [self startEditAlarmRequest:alarm];
}

#pragma mark - DeleteAlarmRequestManagerDelegate

-(void)deleteAlarmManagerDidFinishRequestWithResponse:(NSDictionary *)response
{
    [_tableView setEditing:NO animated:YES];
    
    [self startGetAlarmsRequest];
}

-(void)deleteAlarmManagerDidFinishRequestWithError:(NSError *)error
{
    [_tableView setEditing:NO animated:YES];

    [self showError:error];
}

#pragma mark - EditAlarmRequestManagerDelegate

-(void)editAlarmManagerDidFinishRequestWithResponse:(NSDictionary *)response
{
    [self startGetAlarmsRequest];
}

-(void)editAlarmManagerDidFinishRequestWithError:(NSError *)error
{
    [self showError:error];
}

#pragma mark - Actions

- (IBAction)editButtonPressed:(UIButton *)sender
{
    if (sender.tag == 1) {
        [_editButton setTitle:@"Done"];
        [_tableView setEditing:YES animated:YES];
        sender.tag = 999;
        [_tableView reloadData];
        return;
    }
    
    if (sender.tag == 999) {
        [_editButton setTitle:@"Edit"];
        [_tableView setEditing:NO animated:YES];
        sender.tag = 1;
        [_tableView reloadData];
    }


}

#pragma mark - Requests

-(void)startGetAlarmsRequest
{
    __weak typeof(self) weakSelf = self;
    
    [self showProgressHud];
    
    _getAlarmsRequest = [[APIGetAlarms alloc] init];
    [_getAlarmsRequest startRequestWithCompletionBlock:^(id response, NSError *error) {
        
        [weakSelf hideProgressHud];
        
        if (error) {
            [weakSelf handleGetAlarmsRequestError:error];
        } else
        {
            [weakSelf handleGetAlarmsRequestResponse:response];
        }
    }];
}

-(void)handleGetAlarmsRequestResponse:(NSArray *)response
{
    _alarmsMuttableArray = [NSMutableArray array];
    for (NSDictionary * dict in response) {
        AlarmVO *alarm = [[AlarmVO alloc] initWithDictionary:dict];
        [_alarmsMuttableArray addObject:alarm];
    }
    
    [_tableView reloadData];
}

-(void)handleGetAlarmsRequestError:(NSError *)error
{
    [self showError:error];
}

#pragma mark - Delete Alarm

-(void)startDeleteAlarmRequest:(AlarmVO *)alarm
{
    _deleteAlarmRequestManager = [[DeleteAlarmRequestManager alloc] init];
    _deleteAlarmRequestManager.alarm = alarm;
    _deleteAlarmRequestManager.delegate = self;
    
    [_deleteAlarmRequestManager startRequest];
}

#pragma mark - Edit Alarm

-(void)startEditAlarmRequest:(AlarmVO *)alarm
{
    _editRequestManager = [[EditAlarmRequestManager alloc] init];
    _editRequestManager.delegate = self;
    _editRequestManager.alarm = alarm;

    [_editRequestManager startRequestWithParams:[self createParamsWithAlarm:alarm]];
}

-(NSDictionary *)createParamsWithAlarm:(AlarmVO *)alarm
{    
    NSString *enabledFlag = alarm.enabled ? @"true" : @"false";
    
    NSString *stringHour = [NSString stringWithFormat:@"%ld", (long)alarm.hour];
    NSString *stringMin = [NSString stringWithFormat:@"%ld", (long)alarm.minutes];
    
    NSDictionary *params = @{@"label" : alarm.alarmLabel, @"hour" : stringHour, @"minutes": stringMin, @"enabled" : enabledFlag};
    
    return params;
}

#pragma mark - Request Helpers

-(void)showProgressHud
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideProgressHud
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

-(void)showError:(NSError *)error
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
