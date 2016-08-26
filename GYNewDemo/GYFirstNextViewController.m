//
//  GYFirstNextViewController.m
//  GYNewDemo
//
//  Created by ronmei on 16/6/22.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYFirstNextViewController.h"
#import "GYViewTool.h"

@interface GYFirstNextViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;



@end

@implementation GYFirstNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [GYViewTool viewToolWithFrameChangeFromKeyboard:@[self.textField, self.confirmButton] viewOffTops:@[@60, @60]];
}



- (void)dealloc
{
    NSLog(@"GYFirstNextViewController ------ dealloc");
}



@end
