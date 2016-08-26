//
//  GYNoDataView.h
//  GYNewDemo
//
//  Created by ronmei on 16/6/23.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYNoDataView : UIView


- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)img viewClick:(void(^)())clickBlock;

@end
