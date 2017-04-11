//
//  APIEditAlarm.m
//  Alarm
//
//  Created by Bursuc Andrei on 4/11/17.
//  Copyright © 2017 Andrei Bursuc. All rights reserved.
//

#import "APIEditAlarm.h"
#import <AFNetworking.h>
#import "Constants.h"

@interface APIEditAlarm()

@property(nonatomic, strong) NSString *alarmID;

@end

@implementation APIEditAlarm

- (instancetype)initWithAlarmID:(NSString *)alarmID
{
    self = [super init];
    if (self) {
        self.alarmID = alarmID;
    }
    return self;
}

-(void)startRequestWithParams:(NSDictionary *) params andCompletionBlock:(APICompletionBlock)completionBlock
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[self buildURL]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:kGUID forHTTPHeaderField:@"x-token"];
    
    [manager PUT:@""
      parameters:params
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             completionBlock(responseObject,nil);
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
