//
//  DeleteAlarmRequestManager.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/12/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlarmVO.h"


@protocol DeleteAlarmRequestManagerDelegate <NSObject>

-(void)deleteAlarmManagerDidFinishRequestWithResponse:(NSDictionary *)response;
-(void)deleteAlarmManagerDidFinishRequestWithError:(NSError *)error;

@end

@interface DeleteAlarmRequestManager : NSObject

@property (nonatomic, strong) AlarmVO * alarm;

@property(nonatomic, weak) id <DeleteAlarmRequestManagerDelegate> delegate;

-(void)startRequest;

@end
