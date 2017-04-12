//
//  APIGetAlarms.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/10/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "APIGetAlarms.h"
#import <AFNetworking.h>
#import "Constants.h"

@implementation APIGetAlarms

-(void)startRequestWithCompletionBlock:(APICompletionBlock)completionBlock
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
