//
//  GYNoDataView.m
//  GYNewDemo
//
//  Created by ronmei on 16/6/23.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYNoDataView.h"

@interface GYNoDataView ()

@property (nonatomic, copy) void(^clickBlock)();
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImage *img;
@end


@implementation GYNoDataView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)img viewClick:(void(^)())clickBlock
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.clickBlock = clickBlock;
        self.img = img;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:self.img];
    
    [self addSubview:imgView];
    self.imgView = imgView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImgView:)];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tap];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgView.center = CGPointMake(self.center.x, self.center.y - 64);
}

- (void)clickImgView:(UITapGestureRecognizer *)recognizer
{
    self.clickBlock();
}














@end
