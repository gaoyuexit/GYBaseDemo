//
//  SBChuangYeZhongChouModel.h
//  HJCF
//
//  Created by rongmeikeji on 16/4/15.
//  Copyright © 2016年 fortitude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBChuangYeZhongChouModel : NSObject
/**
 *  期限
 */
@property (nonatomic, copy) NSString *borrow_duration;
/**
 *  利率
 */
@property (nonatomic, copy) NSString *borrow_interest_rate;
/**
 *  金额
 */
@property (nonatomic, copy) NSString *borrow_money;
/**
 *  项目名称
 */
@property (nonatomic, copy) NSString *borrow_name;
/**
 *  项目进度
 */
@property (nonatomic, copy) NSString *progress;
/**
 *  是否是抽奖标
 */
@property (nonatomic, copy) NSString *is_chj;
/**
 *  项目id
 */
@property (nonatomic, copy) NSString *id;
/**
 *  还款类型
 */
@property (nonatomic, copy) NSString *repayment_type;

/**
 *  截止日期
 */
@property (nonatomic, copy) NSString *collect_time;
/**
 *  小图标
 */
@property (nonatomic, copy) NSString *ico;

@end
