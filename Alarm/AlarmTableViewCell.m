//
//  AlarmTableViewCell.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "AlarmTableViewCell.h"

@interface AlarmTableViewCell()
{
    IBOutlet UILabel *_alarmTimeLabel;
    IBOutlet UILabel *_alarmLabel;
    IBOutlet UISwitch *_alarmEnabledSwitch;
    
}
@end

@implementation AlarmTableViewCell

-(void)setupWithAlarm:(AlarmVO *)alarm
{
    NSString *alarmTime = [NSString stringWithFormat:@"%ld : %ld", (long)alarm.hour, (long)alarm.minutes];
    _alarmTimeLabel.text = alarmTime;
    
    _alarmLabel.text = alarm.alarmLabel;
    
    [_alarmEnabledSwitch setOn:alarm.enabled];
    
    BOOL isInEditMode = self.accessoryType == UITableViewCellAccessoryDisclosureIndicator;
    _alarmEnabledSwitch.hidden = isInEditMode;
}

- (IBAction)switchButtonPressed:(UISwitch *)sender
{
    if ([self.delegate respondsToSelector:@selector(alarmTableViewCell:didChangeAlarmState:)]) {
        [self.delegate alarmTableViewCell:self didChangeAlarmState:sender.isOn];
    }
}


@end
