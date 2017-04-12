//
//  EditAlarmRequestManager.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/11/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlarmVO.h"

@protocol EditAlarmRequestManagerDelegate <NSObject>

-(void)editAlarmManagerDidFinishRequestWithResponse:(NSDictionary *)response;
-(void)editAlarmManagerDidFinishRequestWithError:(NSError *)error;

@end

@interface EditAlarmRequestManager : NSObject

@property (nonatomic, strong) AlarmVO * alarm;

@property(nonatomic, weak) id <EditAlarmRequestManagerDelegate> delegate;

-(void)startRequestWithParams:(NSDictionary *)params;

@end
