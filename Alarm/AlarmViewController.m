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

@interface AlarmViewController ()<UITableViewDelegate, UITableViewDataSource,AddAlarmViewControllerDelegate>
{
    IBOutlet UITableView *_tableView;
    
    NSMutableArray * _alarmsMuttableArray;
}

@property(nonatomic, strong) APIGetAlarms* getAlarmsRequest;

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

#pragma mark - AddAlarmViewControllerDelegate

-(void)addAlarmVC:(AddAlarmViewController *)viewController didSaveAlarm:(AlarmVO *)alarm
{
    [_alarmsMuttableArray addObject:alarm];
    [_tableView reloadData];
}

#pragma mark UITableViewDataSource

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
    
    [cell setupWithAlarm:_alarmsMuttableArray[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - Requests

-(void)startGetAlarmsRequest
{
    __weak typeof(self) weakSelf = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    _getAlarmsRequest = [[APIGetAlarms alloc] init];
    [_getAlarmsRequest startRequestWithCompletionBlock:^(id response, NSError *error) {
      
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
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
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
