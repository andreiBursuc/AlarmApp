//
//  APIGetAlarms.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "APIGetAlarms.h"
#import <AFNetworking.h>

#define kAPIBaseURL  @"http://red.maxcode.net/api/clocks"
#define kGUID  @"b8d1c2ad-621b-45a4-8446-eb3676289e82"

@implementation APIGetAlarms

-(void)startRequestWithCompletionBlock:(APIManagerCompletionBlock)completionBlock
{
    NSURL *url = [NSURL URLWithString:kAPIBaseURL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:kGUID forHTTPHeaderField:@"x-token"];
    
    [manager GET:@""
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             completionBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionBlock(nil, error);
    }];
}

@end
