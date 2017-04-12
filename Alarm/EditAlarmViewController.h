//
//  EditAlarmViewController.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/11/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmVO.h"

@protocol EditAlarmViewControllerDelegate <NSObject>

-(void)editAlarmViewControllerDidEditAlarm:(AlarmVO *)alarm;

@end

@interface EditAlarmViewController : UIViewController

@property (nonatomic, strong) AlarmVO * alarm;

@property (nonatomic, weak) id <EditAlarmViewControllerDelegate>delegate;

@end
