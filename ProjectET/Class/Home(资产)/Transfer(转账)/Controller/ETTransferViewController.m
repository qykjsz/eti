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

@interface ETTransferViewController ()<UITableViewDelegate,UITableViewDataSource,ETTransferViewDelegate>

@property (nonatomic,strong) UITableView *detailTab;

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
    
    
}

- (void)popAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETTransferCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETTransferCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    }
    return _detailTab;
}

@end
