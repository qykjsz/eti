//
//  ETProclamationListController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETProclamationListController.h"
#import "ETNewsDetailController.h"

#import "ETProclamListCell.h"

#import "ETNewsListModel.h"
#import "UUID.h"

@interface ETProclamationListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger currentPage;

@end

@implementation ETProclamationListController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.currentPage = 0;
    [self newsRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"平台公告";
    self.view.backgroundColor = UIColor.whiteColor;
    self.dataArr = [NSMutableArray array];
    [self.view addSubview:self.detailTab];
    WEAK_SELF(self);
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        STRONG_SELF(self);
        make.edges.equalTo(self.view);
        
    }];
    
    [self newsRequest];
}

- (void)newsRequest {
    
    NSString *uuidString = [UUID getUUID];
    [HTTPTool requestDotNetWithURLString:@"et_notice" parameters:@{@"page":@(self.currentPage),@"contacts":uuidString} type:kPOST success:^(id responseObject) {
        
        if (self.currentPage == 0) {
            [self.dataArr removeAllObjects];
        }
        
        ETNewsListModel *moel = [ETNewsListModel mj_objectWithKeyValues:responseObject];
        [self.dataArr addObjectsFromArray:moel.data.News];
        
        [self.detailTab reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETProclamListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETProclamListCell"];
    cell.model = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 64;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETNewsDetailController *dVC = [ETNewsDetailController new];
    ETNewsData *data = self.dataArr[indexPath.row];
    dVC.Id = data.Id;
    [self.navigationController pushViewController:dVC animated:YES];
    
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETProclamListCell class] forCellReuseIdentifier:@"ETProclamListCell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
        WEAK_SELF(self);
        _detailTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            STRONG_SELF(self);
            self.currentPage = 0;
            [self.detailTab.mj_header endRefreshing];
            [self newsRequest];
        }];
        
        _detailTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            STRONG_SELF(self);
            [self.detailTab.mj_footer endRefreshing];
            self.currentPage += 1;
            [self newsRequest];
        }];

    }
    return _detailTab;
}

@end
