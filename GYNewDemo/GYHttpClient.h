//
//  GYHttpClient.h
//  GYNewDemo
//
//  Created by 郜宇 on 16/6/20.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import <AFNetworking.h>

@interface GYHttpClient : NSObject


@property (nonatomic, weak) AFHTTPSessionManager *sessionManager;


+ (id)sharedGYHttpClient;

- (void)updateMyZoeUserBaseData:(NSDictionary *)dict withHUD:(BOOL)hud success:(void (^)(BOOL isSuccess,id respone))success failure:(void (^)(NSError *error))failure;


- (void)getHuiCangDaiList:(NSDictionary *)dict withHUD:(BOOL)hud success:(void (^)(BOOL isSuccess,id respone))success failure:(void (^)(NSError *error))failure;





@end
