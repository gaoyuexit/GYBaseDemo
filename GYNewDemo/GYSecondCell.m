//
//  GYSecondCell.m
//  GYNewDemo
//
//  Created by ronmei on 16/6/23.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYSecondCell.h"
#import "SBChuangYeZhongChouModel.h"

@interface GYSecondCell ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end


@implementation GYSecondCell

- (void)setModel:(id)model
{
    [super setModel:model];

    self.testLabel.backgroundColor = [UIColor redColor];
    self.testLabel.text = ((SBChuangYeZhongChouModel *)model).borrow_name;
}

@end
