//
//  GYSecondTableViewController.m
//  GYNewDemo
//
//  Created by ronmei on 16/6/22.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYSecondTableViewController.h"
#import "GYSecondCell.h"
#import "MJExtension.h"
#import "GYHttpClient.h"
#import "SBChuangYeZhongChouModel.h"
#import "UITableView+placeholder.h"
@interface GYSecondTableViewController ()

@property (nonatomic, assign) int index;

@end

@implementation GYSecondTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    [self setupTableViewCell:[GYSecondCell class] identifier:@"111" isXIB:YES];
    
    [self loadNewData];
    
}


- (void)loadNewData
{
    self.index++;
    
    self.currentPage = 1;
    [self.tableView.mj_footer endRefreshing];
    
    GYHttpClient *httpClient = [GYHttpClient sharedGYHttpClient];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"p"] = @"1";
    [httpClient getHuiCangDaiList:params withHUD:NO success:^(BOOL isSuccess, id respone) {
        NSArray *borrow_data = respone[@"borrow_data"];
        NSNumber *totalpage = respone[@"totalpage"];
        if ([totalpage isEqualToNumber:@1]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        NSMutableArray *temArray = [NSMutableArray array];
        for (NSDictionary *dict in borrow_data) {
            SBChuangYeZhongChouModel *temM = [SBChuangYeZhongChouModel mj_objectWithKeyValues:dict];
            [temArray addObject:temM];
        }
        self.contentArray = temArray;
        if (self.index % 2 == 0) {
            [self.contentArray removeAllObjects];

        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

    }];
}









@end
