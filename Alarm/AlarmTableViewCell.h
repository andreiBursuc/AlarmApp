//
//  AlarmTableViewCell.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmVO.h"

@interface AlarmTableViewCell : UITableViewCell

-(void)setupWithAlarm:(AlarmVO *)alarm;

@end
