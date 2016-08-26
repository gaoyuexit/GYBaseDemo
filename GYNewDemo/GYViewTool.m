//
//  GYViewTool.m
//  GYNewDemo
//
//  Created by ronmei on 16/6/22.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYViewTool.h"

@interface GYViewTool ()

@end

static  NSArray          *_views;
static  NSArray          *_tops;

@implementation GYViewTool



+ (void)viewToolWithFrameChangeFromKeyboard:(NSArray *)views viewOffTops:(NSArray <NSNumber *>*)tops;
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    _views = views;
    _tops = tops;
}


+ (void)didClickKeyboard:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGRect frame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    [_views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            
            CGFloat offsetY = _tops?[_tops[idx] doubleValue]:frame.size.height;
            
            [UIView animateWithDuration:duration animations:^{
                ((UIView *)obj).transform = CGAffineTransformMakeTranslation(0, -offsetY);
            }];
        }
    }];
}

+ (void)didKboardDisappear:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [_views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            
            [UIView animateWithDuration:duration animations:^{
                ((UIView *)obj).transform = CGAffineTransformIdentity;
            }];
        }
    }];
}



- (void)dealloc
{
    NSLog(@"GYViewTool-------dealloc");
}


@end
