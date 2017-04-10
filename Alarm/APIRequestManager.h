//
//  APIRequestManager.h
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^APIManagerCompletionBlock) (id response, NSError *error);

@interface APIRequestManager : NSObject

- (void)startRequest:(NSURLRequest*)request withCompletionBlock:(APIManagerCompletionBlock)completionBlock;

@end
