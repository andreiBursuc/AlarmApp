//
//  AddAlarmViewController.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmVO.h"

@class AddAlarmViewController;

@protocol AddAlarmViewControllerDelegate <NSObject>

-(void)addAlarmVC: (AddAlarmViewController *)viewController didSaveAlarm: (AlarmVO *)alarm;

@end

@interface AddAlarmViewController : UIViewController

@property (nonatomic, weak) id <AddAlarmViewControllerDelegate> delegate;

@end
