//
//  APICreateAlarm.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/11/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIProtocol.h"

@interface APICreateAlarm : NSObject

-(void)startRequestWithParams:(NSDictionary *) params andCompletionBlock:(APICompletionBlock)completionBlock;


@end
