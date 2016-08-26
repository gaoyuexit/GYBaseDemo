//
//  GYSecondNextCell.m
//  GYNewDemo
//
//  Created by ronmei on 16/6/23.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYSecondNextCell.h"
#import "SBChuangYeZhongChouModel.h"
@implementation GYSecondNextCell

- (void)setModel:(id)model
{
    [super setModel:model];
    
    self.textLabel.text = ((SBChuangYeZhongChouModel *)model).borrow_money;
}

@end
