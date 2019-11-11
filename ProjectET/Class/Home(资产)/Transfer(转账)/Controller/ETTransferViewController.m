//
//  ETTransferViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransferViewController.h"
#import "ETDirectTransferController.h"
#import "ETScanViewController.h"
#import "ETMyContactsController.h"

#import "ETTransferView.h"
#import "ETTransferCell.h"

#import "ETTransListModel.h"

@interface ETTransferViewController ()<UITableViewDelegate,UITableViewDataSource,ETTransferViewDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger curretnPage;


@end

@implementation ETTransferViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        
    }];
    
    UIButton *popBtn = [[UIButton alloc]init];
    [popBtn setImage:[UIImage imageNamed:@"fh_icon_white"] forState:UIControlStateNormal];
    [popBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [popBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [popBtn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:popBtn];
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImage.mas_top).offset(20);
        make.width.height.equalTo(@44);
        
    }];
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"转账";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.centerY.equalTo(popBtn.mas_centerY);
        
    }];
    
    ETTransferView *headerView = [[ETTransferView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145)];
    headerView.delegate = self;
    [self.view addSubview:self.detailTab];
    self.detailTab.tableHeaderView = headerView;
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImage.mas_bottom).offset(-20);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
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

- (void)popAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETTransferCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETTransferCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    orderData *data = self.dataArr[indexPath.row];
    cell.model = data;
    return cell;
}

#pragma mark - ETTransferViewDelegate

- (void)ETTransferViewDelegateWithClikTag:(NSInteger)tag {
    
    if (tag == 0) {
        ETDirectTransferController *dtVC = [ETDirectTransferController new];
        [self.navigationController pushViewController:dtVC animated:YES];
    }else if (tag == 1) {
        ETMyContactsController *cVC = [ETMyContactsController new];
        [self.navigationController pushViewController:cVC animated:YES];
    }else {
        ETScanViewController *sVC = [ETScanViewController new];
        sVC.isDirection = YES;
        [self.navigationController pushViewController:sVC animated:YES];
    }
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETTransferCell class] forCellReuseIdentifier:@"ETTransferCell"];
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

@end
