//
//  BaseNavigationController.m
//  XiaoPeng
//
//  Created by whj on 15/11/27.
//  Copyright © 2015年 whj. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController
/**
 *  系统在第一次使用这个类的时候调用(1个类只会调用一次)--合适的代码放在合适的地方。=
 */
+(void)initialize{
    //修改 导航条的样式 统一修改 只修改一次 --合适的代码要放在合适的位置
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.shadowImage = [[UIImage alloc] init];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    //导航条的 tittle的 样式设置 。
    navBar.titleTextAttributes = @{
                                   NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:18],
                                   NSForegroundColorAttributeName:[UIColor whiteColor],
                                   };
}

/** 重写改方法拦截 所有的 push 操作。*/
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //拦截 被压入 栈 的 控制器
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal
         ];
        // backButton.backgroundColor = OrangeColor;
        backButton.frame = CGRectMake(0, 0, 50, 40);
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = leftItem;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"base--nav----%@",self);
    //当使用这个属性的时候 ，控制器的View是从导航栏的下面开始的。但是如果隐藏了导航栏，tableview的Frame是占据整个屏幕的。
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //使左滑手势在自定义了leftBarButtonItem仍然有效
    __weak typeof(self)weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
    //监听到错误登录的通知(也就是异处登录强制下线的通知)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(errorLogin:) name:@"errorLogin" object:nil];
}


- (void)errorLogin:(NSNotification *)notification
{
    [self.tabBarController setSelectedIndex:3];
    [self popToRootViewControllerAnimated:YES];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"errorLogin" object:nil];
}



@end
