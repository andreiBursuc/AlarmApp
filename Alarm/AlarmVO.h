//
//  AlarmVO.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmVO : NSObject

@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * alarmID;
@property (nonatomic, strong) NSString * alarmLabel;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
