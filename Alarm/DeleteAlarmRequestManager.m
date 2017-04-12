//
//  DeleteAlarmRequestManager.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/12/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "DeleteAlarmRequestManager.h"
#import "APIDeleteAlarm.h"

@interface DeleteAlarmRequestManager()

@property (nonatomic, strong) APIDeleteAlarm *deleteAlarmRequest;

@end

@implementation DeleteAlarmRequestManager

-(void)startRequest {
    __weak typeof(self) weakSelf = self;
    
    
    _deleteAlarmRequest = [[APIDeleteAlarm alloc] initWithAlarmID:self.alarm.alarmID];
    
    [_deleteAlarmRequest startRequestWithCompletionBlock:^(id response, NSError *error) {
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
    if ([self.delegate respondsToSelector:@selector(deleteAlarmManagerDidFinishRequestWithResponse:)]) {
        [self.delegate deleteAlarmManagerDidFinishRequestWithResponse:response];
    }
}

-(void)handleEditAlarmsRequestError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(deleteAlarmManagerDidFinishRequestWithError:)]) {
        [self.delegate deleteAlarmManagerDidFinishRequestWithError:error];
    }
}

@end
