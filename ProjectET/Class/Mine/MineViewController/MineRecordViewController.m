//
//  MineRecordViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MineRecordViewController.h"
#import "ETRecordCell.h"
#import "ETTransListModel.h"
#import "ETTransferDetailViewController.h"

@interface MineRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger curretnPage;

@end

@implementation MineRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易记录";
    self.dataArr = [NSMutableArray array];
   
    self.curretnPage = 0;
    [self.view addSubview:self.detailTab];
    
    [self listRequest];
   
}

#pragma Mark- NET
- (void)listRequest {
    
    /*
     address 复制    [string]    是    地址
     page    [string]    是    当前页数 从0开始
     glod    [string]    是    查询币种 如 ETH 传0为全部币种
     type    [string]    是    交易类型 1.转入 2.转入 3.全部
     */
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:model.address forKey:@"address"];
    [dict setValue:@(self.curretnPage) forKey:@"page"];
    [dict setValue:@"0" forKey:@"glod"];
    [dict setValue:@"3" forKey:@"type"];
    [HTTPTool requestDotNetWithURLString:@"et_recordorder" parameters:dict type:kPOST success:^(id responseObject) {
        
        
        if (self.curretnPage == 0) {
            [self.dataArr removeAllObjects];
        }
        ETTransListModel *model = [ETTransListModel mj_objectWithKeyValues:responseObject];
        
        [self.dataArr addObjectsFromArray:model.data.order];
        
        if (self.dataArr.count == [model.data.pages integerValue]) {
            [self.detailTab.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETRecordCell class] forCellReuseIdentifier:@"ETRecordCell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
        
        WEAK_SELF(self);
        _detailTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            STRONG_SELF(self);
            self.curretnPage = 0;
            [self.detailTab.mj_header endRefreshing];
            [self listRequest];
        }];
        
        _detailTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            STRONG_SELF(self);
            [self.detailTab.mj_footer endRefreshing];
            self.curretnPage += 1;
            [self listRequest];
        }];
    }
    return _detailTab;
}
#pragma mark--------DELEGATE-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 66;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETRecordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    orderData *data = self.dataArr[indexPath.row];
    cell.model = data;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    orderData *data = self.dataArr[indexPath.row];
    ETTransferDetailViewController *dVC = [ETTransferDetailViewController new];
    dVC.Id = data.Id;
    dVC.glod = data.name;
    dVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dVC animated:YES];
}
@end
