//
//  APIGetAlarms.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIProtocol.h"


@interface APIGetAlarms : NSObject

-(void)startRequestWithCompletionBlock:(APICompletionBlock)completionBlock;

@end
