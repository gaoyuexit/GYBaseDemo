//
//  GYHttpClient.m
//  GYNewDemo
//
//  Created by 郜宇 on 16/6/20.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYHttpClient.h"
#import "GYProgressHUD.h"
#import "DMCAlertCenter.h"
@implementation GYHttpClient

SYNTHESIZE_SINGLETON_FOR_CLASS(GYHttpClient)



- (void)updateMyZoeUserBaseData:(NSDictionary *)dict withHUD:(BOOL)hud success:(void (^)(BOOL isSuccess,id respone))success failure:(void (^)(NSError *error))failure
{
    [self httpGet:@"http://hjp2p.ronmei.com/mapp/member" params:nil withHUD:hud success:^(BOOL isSuccess, id responsObject) {
        
        success(isSuccess,responsObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getHuiCangDaiList:(NSDictionary *)dict withHUD:(BOOL)hud success:(void (^)(BOOL isSuccess,id respone))success failure:(void (^)(NSError *error))failure
{
    [self httpGet:@"http://www.cheyidai8.com/mapp/borrowlist?type=5" params:dict withHUD:hud success:^(BOOL isSuccess, id responsObject) {
        success(isSuccess,responsObject);
    } failure:^(NSError *error) {
        failure(error);

    }];
}



#pragma mark - 底层的get
- (void)httpGet:(NSString *)urlString
         params:(id)params
         withHUD:(BOOL)hud
        success:(void(^)(BOOL isSuccess ,id responsObject))success
        failure:(void(^)(NSError *error))failure
{
    hud == NO ? : [GYProgressHUD show];

    NSLog(@"\n**************** GET请求 ****************\n");
    NSLog(@"\n**************** 请求=路径 ****************\n");
    NSLog(@"%@",urlString);
    NSLog(@"\n**************** 请求=参数 ****************\n\n");
    NSLog(@"%@ ",params);
    
    [[self sessionManager] GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        hud == NO ? : [GYProgressHUD dismiss];
        
        NSNumber *status = responseObject[@"status"];
        NSNumber *resCode = responseObject[@"resultCode"];
        NSString *message = responseObject[@"message"];
        if ([status isEqual:@(1)]) {
            success(YES, responseObject);
        }else{
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:message];
            success(NO, responseObject);
        }
        if ([resCode isEqual:@(12)]) {
            NSLog(@"用户在其他地方登陆");
            // 这里发送通知就可以
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        hud == NO ? : [GYProgressHUD dismiss];
        
        if (error.code == NSURLErrorCancelled) return ;
        if (error.code == NSURLErrorTimedOut) { // 超时
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"网络超时"];
        }else{
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"网络异常"];
        }
    }];
}


- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 10;
    }
    return _sessionManager;
}



@end
