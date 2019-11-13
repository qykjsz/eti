//
//  ETTotalAssetsController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTotalAssetsController.h"
#import "ETConiCell.h"
#import "ETRecordHeaderView.h"
#import "ETHashSearchModel.h"

@interface ETTotalAssetsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) ETRecordHeaderView *headerView;

@property (nonatomic,strong) ETHashSearchModel *model;
@end

@implementation ETTotalAssetsController

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
    titleLb.text = @"总资产";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.centerY.equalTo(popBtn.mas_centerY);
        
    }];
    
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
       
//        make.edges.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        
    }];
    
    self.headerView = [[ETRecordHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    self.detailTab.tableHeaderView = self.headerView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eyeAction:) name:@"RECODEREYEACTION" object:nil];
    
    [self detailRequest];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETConiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETConiCell"];
//    glodData *data = self.dataArr[indexPath.row];
//
//    cell.model = self.dataArr[indexPath.row];
//    if (!self.isOpen) {
//        cell.topDollor.text = @"****.**";
//        cell.bottomDollor.text = @"****.**";
//    }else {
//        cell.topDollor.text = data.number;
//        cell.bottomDollor.text = [NSString stringWithFormat:@"$ %@",data.usdtnumber];
//        cell.coninName.text = data.name;
//    }
    
    return  cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = UIColor.whiteColor;
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, 30)];
    titleLb.font = [UIFont systemFontOfSize:14];
    titleLb.textColor = UIColorFromHEX(0x333333, 1);
    titleLb.text = @"尼古拉斯赵四";
    [view addSubview:titleLb];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
    
}

#pragma mark - Action
- (void)popAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)eyeAction:(NSNotification *)sender {
    
    if ([sender.object[@"isOpen"] boolValue]) {
        
        self.headerView.moneyLb.text = @"999.99";
        self.headerView.subMoneyLb.text = @"≈$ 638383.7889";
        self.headerView.todayLb.text = @"今日 +120.36";
    }else {
        
        self.headerView.moneyLb.text = @"***.**";
        self.headerView.subMoneyLb.text = @"≈$ ***.**";
        self.headerView.todayLb.text = @"******";
    }
}

#pragma mark - NET
- (void)detailRequest {
    
    NSMutableArray *data = [NSMutableArray array];
    NSMutableArray *walletArr = WALLET_ARR;
    for (ETWalletModel *model in walletArr) {
        NSDictionary *dict = @{@"address":model.address};
        [data addObject:dict];
    }
    [HTTPTool requestDotNetWithURLString:@"et_allassets" parameters:@{@"alladdress":data} type:kPOST success:^(id responseObject) {
        self.model = [ETHashSearchModel mj_objectWithKeyValues:responseObject];
        NSLog(@"%@",self.model);
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETConiCell class] forCellReuseIdentifier:@"ETConiCell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
//        WEAK_SELF(self);
//        _detailTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//            STRONG_SELF(self);
//            self.currentPage = 0;
//            [self.detailTab.mj_header endRefreshing];
//            [self newsRequest];
//        }];
//
//        _detailTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//            STRONG_SELF(self);
//            [self.detailTab.mj_footer endRefreshing];
//            self.currentPage += 1;
//            [self newsRequest];
//        }];
        
    }
    return _detailTab;
}

@end
