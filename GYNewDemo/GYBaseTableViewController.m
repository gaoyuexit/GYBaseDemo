//
//  GYBaseTableViewController.m
//  GYNewDemo
//
//  Created by ronmei on 16/6/22.
//  Copyright © 2016年 郜宇. All rights reserved.
//

#import "GYBaseTableViewController.h"
#import "GYBaseCell.h"
#import "GYNoDataView.h"
#import "UITableView+placeholder.h"
#import "GYHttpClient.h"
@interface GYBaseTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Class tableViewcell;
@property (nonatomic, assign) BOOL isXib;


@end

static NSString *_ID;
@implementation GYBaseTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableView];

    
//    [self.tableView.mj_header beginRefreshing];

}

- (void)setupTableViewCell:(Class)tableViewcell identifier:(NSString *)identifier isXIB:(BOOL)isXib
{
    _ID = identifier;
    self.tableViewcell = tableViewcell;
    self.isXib = isXib;
}


#pragma mark - lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_header = header;
        _tableView.placeHolderView = [[GYNoDataView alloc] initWithFrame:self.view.bounds image:[UIImage imageNamed:@"no_data"] viewClick:^{
            NSLog(@"点击了没有更多数据的按钮");
//            [self noDataButtonClick];
            // 子类进行子类的loadNewData方法
            [self loadNewData];
        }];
        if ([_tableView  respondsToSelector:@selector(setSeparatorInset:)])
        {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        header.lastUpdatedTimeLabel.hidden = YES;
        // 设置文字
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松手刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"让您的每一分钱安全有回报" forState:MJRefreshStateRefreshing];
        // 设置字体
        header.stateLabel.font = [UIFont fontWithName:@"Heiti TC" size:14];
    }
    return _tableView;
}

- (void)loadNewData{}

//- (void)noDataButtonClick{}


#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (GYBaseCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GYBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:_ID];
    
    if (cell == nil) {
        if (self.isXib) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.tableViewcell) owner:self options:0] lastObject];

        }else{
            cell = [[self.tableViewcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_ID];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(GYBaseCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.model = self.contentArray[indexPath.row];
}


#pragma mark - lazy
- (NSMutableArray *)contentArray
{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}


- (void)dealloc
{
 
    
    // 停止请求(一个session对应一个manager,这里直接将所有的请求挂掉,不能继续请求了,除非再创建一个manager)
    [[[GYHttpClient sharedGYHttpClient] sessionManager] invalidateSessionCancelingTasks:YES];
    
    // 同上,取消所有的任务(这句代码是取消任务挂掉后,还可以继续发送请求), 和上面的有点区别
//    [[[GYHttpClient sharedGYHttpClient] sessionManager].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 这个取消在请求类中,如果取消了任务,直接到下载失败的回调中了,让HUD隐藏, 不在这里操作了
    //    [GYProgressHUD dismiss];
}








@end
