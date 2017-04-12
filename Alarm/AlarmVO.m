//
//  AlarmVO.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "AlarmVO.h"

@implementation AlarmVO

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.minutes = [dict[@"minutes"] integerValue];
        self.hour = [dict[@"hour"] integerValue];
        self.enabled = [dict[@"enabled"] boolValue];
        self.alarmID = dict[@"id"];
        self.alarmLabel = dict[@"label"];
    }
    return self;
}

@end
