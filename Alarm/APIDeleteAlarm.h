//
//  APIDeleteAlarm.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/12/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIProtocol.h"

@interface APIDeleteAlarm : NSObject

-(instancetype)initWithAlarmID:(NSString *)alarmID;

-(void)startRequestWithCompletionBlock:(APICompletionBlock)completionBlock;

@end
