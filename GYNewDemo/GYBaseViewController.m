//
//  GYBaseViewController.m
//  GYNewDemo
//
//  Created by ronmei on 16/6/22.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYBaseViewController.h"

@interface GYBaseViewController ()

@end

@implementation GYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这里的颜色,在pch全局中写成宏GlobalBgColor
    self.view.backgroundColor = [UIColor redColor];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 在基类的控制器再添加一个监听键盘的方法, 让子类去继承,然后修改布局
// TODO(根据工具类的方法写)
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 添加观察着
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 移除观察着
}





@end
