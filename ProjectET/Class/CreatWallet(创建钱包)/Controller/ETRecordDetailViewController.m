//
//  ETRecordDetailViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/1.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETRecordDetailViewController.h"
#import "ETTransferDetailViewController.h"

#import "ETRecordHeaderView.h"
#import "ETRecordCell.h"

#import "ETMyContactsCell.h"

#import "ETTransListModel.h"
#import "ETHashSearchModel.h"

@interface ETRecordDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger curretnPage;

@property (nonatomic,strong) ETTransListModel *model;

@property (nonatomic,strong) ETHashSearchModel *searchModel;

@property (nonatomic,assign) BOOL isSearch;

@end

@implementation ETRecordDetailViewController

- (void)setOffsetY:(CGFloat)offsetY{
    self.detailTab.contentOffset = CGPointMake(0, offsetY);
}

- (CGFloat)offsetY{
    return self.detailTab.contentOffset.y;
}

- (void)setIsCanScroll:(BOOL)isCanScroll{
    if (isCanScroll == YES){
        [self.detailTab setContentOffset:CGPointMake(0, self.offsetY) animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.scrollDelegate respondsToSelector:@selector(hoverChildViewController:scrollViewDidScroll:)]){
        [self.scrollDelegate hoverChildViewController:self scrollViewDidScroll:scrollView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isOpen = YES;
    self.dataArr = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eyeAction:) name:@"RECODEREYEACTION" object:nil];
    
    self.detailTab.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 85 - 64 - 50);
    
    [self.view addSubview:self.detailTab];
    
    [self listRequest];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self listRequest];
}

#pragma mark - Noticfication
- (void)eyeAction:(NSNotification *)sender {
    
    if ([sender.object[@"isOpen"] boolValue]) {
        
        self.isOpen = YES;
    }else {
        
        self.isOpen = NO;
        
    }
    
    [self.detailTab reloadData];
}


- (void)setTemg:(NSString *)temg {
    
    _temg = temg;
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:model.address forKey:@"address"];
    [dict setValue:temg forKey:@"hash"];
    [dict setValue:self.coinName forKey:@"glod"];
    [HTTPTool requestDotNetWithURLString:@"et_recordorderhash" parameters:dict type:kPOST success:^(id responseObject) {
        
        self.isSearch = YES;
        self.searchModel = [ETHashSearchModel mj_objectWithKeyValues:responseObject];
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    if ([Tools checkStringIsEmpty:temg]) {
        self.isSearch = NO;
        [self.detailTab reloadData];
    }
    
}
#pragma Mark- NET
- (void)listRequest {
    
    /*
     address 复制    [string]    是    地址
     page    [string]    是    当前页数 从0开始
     glod    [string]    是    查询币种 如 ETH 传0为全部币种
     type    [string]    是    交易类型 1.转入 2.转入 3.全部
     */
    if (self.coinName == nil) {
        self.coinName = @"0";
        self.type = @"3";
    }
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:model.address forKey:@"address"];
    [dict setValue:@(self.curretnPage) forKey:@"page"];
    [dict setValue:self.coinName forKey:@"glod"];
    [dict setValue:self.type forKey:@"type"];
    [HTTPTool requestDotNetWithURLString:@"et_recordorder" parameters:dict type:kPOST success:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        if (self.curretnPage == 0) {
            [self.dataArr removeAllObjects];
        }
        self.model = [ETTransListModel mj_objectWithKeyValues:responseObject];
        
        [self.dataArr addObjectsFromArray:self.model.data.order];
        
        if (self.dataArr.count == [self.model.data.pages integerValue]) {
            [self.detailTab.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
         [SVProgressHUD dismiss];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
        
    if (self.isSearch) {
        if (self.searchModel.data) {
            return 1;
        }else {
            return 0;
        }
    }
        

    return self.dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 98;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETRecordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.isOpen) {
        
        if (self.isSearch) {
            cell.data = self.searchModel.data;
        }else {
            orderData *data = self.dataArr[indexPath.row];
            cell.model = data;
        }
        
    }else {
        cell.moneydetail.text = @"*****";
        cell.statusDetail.text = @"***";
        cell.timeDetail.text = @"****/**/** **:**";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    orderData *data = self.dataArr[indexPath.row];
    ETTransferDetailViewController *tVC = [ETTransferDetailViewController new];
    tVC.Id = data.Id;
    tVC.glod = data.name;
    [self.navigationController pushViewController:tVC animated:YES];
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
