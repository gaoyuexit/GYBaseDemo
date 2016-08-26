//
//  GYSecondNextTableViewController.m
//  GYNewDemo
//
//  Created by ronmei on 16/6/23.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYSecondNextTableViewController.h"
#import "GYBaseCell.h"
#import "GYSecondNextCell.h"
#import "UITableView+placeholder.h"
#import "GYHttpClient.h"
#import "SBChuangYeZhongChouModel.h"
#import "MJExtension.h"
@interface GYSecondNextTableViewController ()
@property (nonatomic, assign) int index;

@end

@implementation GYSecondNextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableViewCell:[GYSecondNextCell class] identifier:@"222" isXIB:NO];

    self.index = 0;
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
    [httpClient getHuiCangDaiList:params withHUD:YES success:^(BOOL isSuccess, id respone) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
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
            
        });
   
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
    }];
}





@end
