//
//  APICreateAlarm.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/11/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "APICreateAlarm.h"
#import "Constants.h"
#import <AFNetworking.h>

@implementation APICreateAlarm

-(void)startRequestWithParams:(NSDictionary *)params andCompletionBlock:(APICompletionBlock)completionBlock
{
    NSURL *url = [NSURL URLWithString:kAPIBaseURL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:kGUID forHTTPHeaderField:@"x-token"];
    
    [manager POST:@""
       parameters:params
         progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             completionBlock(responseObject,nil);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             completionBlock(nil, error);

         }];
}

@end
