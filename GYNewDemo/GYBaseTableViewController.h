//
//  GYBaseTableViewController.h
//  GYNewDemo
//
//  Created by ronmei on 16/6/22.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYBaseViewController.h"
#import "MJRefresh.h"

@interface GYBaseTableViewController : GYBaseViewController

@property (nonatomic, strong) NSMutableArray *contentArray;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UITableView *tableView;


/**
 * 设置TableViewCell
 * @author 郜宇
 */
- (void)setupTableViewCell:(Class)tableViewcell identifier:(NSString *)identifier isXIB:(BOOL)isXib;


@end
