//
//  EditAlarmRequestManager.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/11/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "EditAlarmRequestManager.h"
#import "APIEditAlarm.h"

@interface EditAlarmRequestManager()

@property (nonatomic, strong) APIEditAlarm *editAlarmRequest;

@end

@implementation EditAlarmRequestManager

-(void)startRequestWithParams:(NSDictionary *)params {
    __weak typeof(self) weakSelf = self;
    
    
    _editAlarmRequest = [[APIEditAlarm alloc] initWithAlarmID:self.alarm.alarmID];
    
    [_editAlarmRequest startRequestWithParams:params andCompletionBlock:^(id response, NSError *error) {
        if (error) {
            [weakSelf handleEditAlarmsRequestError:error];
        } else
        {
            [weakSelf handleEditAlarmsRequestResponse:response];
        }
    }];
}

-(void)handleEditAlarmsRequestResponse:(NSDictionary *)response
{
    if ([self.delegate respondsToSelector:@selector(editAlarmManagerDidFinishRequestWithResponse:)]) {
        [self.delegate editAlarmManagerDidFinishRequestWithResponse:response];
    }
}

-(void)handleEditAlarmsRequestError:(NSError *)error
{    
    if ([self.delegate respondsToSelector:@selector(editAlarmManagerDidFinishRequestWithError:)]) {
        [self.delegate editAlarmManagerDidFinishRequestWithError:error];
    }
}

@end
