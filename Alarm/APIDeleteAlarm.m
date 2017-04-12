//
//  APIDeleteAlarm.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/12/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "APIDeleteAlarm.h"
#import <AFNetworking.h>
#import "Constants.h"

@interface APIDeleteAlarm()

@property(nonatomic, strong) NSString *alarmID;

@end

@implementation APIDeleteAlarm

- (instancetype)initWithAlarmID:(NSString *)alarmID
{
    self = [super init];
    if (self) {
        self.alarmID = alarmID;
    }
    return self;
}

-(void)startRequestWithCompletionBlock:(APICompletionBlock)completionBlock
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[self buildURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:kGUID forHTTPHeaderField:@"x-token"];
    
    [manager DELETE:@""
         parameters:nil
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                completionBlock(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                completionBlock(nil, error);
            }];
}

-(NSURL *)buildURL
{
    NSString * stringURL = [NSString stringWithFormat:@"%@/%@", kAPIBaseURL, self.alarmID];
    
    return [NSURL URLWithString:stringURL];
}

@end
