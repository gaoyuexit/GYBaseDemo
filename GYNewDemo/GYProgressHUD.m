//
//  GYProgressHUD.m
//  GYNewDemo
//
//  Created by 郜宇 on 16/6/20.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYProgressHUD.h"
@implementation GYProgressHUD

+ (void)show
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}

+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

@end
