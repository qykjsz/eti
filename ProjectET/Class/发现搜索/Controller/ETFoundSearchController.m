//
//  ETFoundSearchController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundSearchController.h"
#import "ETHTMLViewController.h"

// view
#import "ETFoundSectionView.h"
#import "ETFoundSerarchNavView.h"
#import "ETFoundSearchCollectionView.h"
#import "ETFoundSearchDetailCell.h"

@interface ETFoundSearchController ()<ETFoundSerarchNavViewDelegate,ETFoundSearchCollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) ETFoundSectionView *sectionView;

@property (nonatomic,strong) ETFoundSearchCollectionView *headerView;

@property (nonatomic,strong) ETFoundSerarchNavView *navView;

@property (nonatomic,strong) UITableView *detailTab;

@end

@implementation ETFoundSearchController

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
    
    self.view.backgroundColor = UIColorFromHEX(0xf5f5f5, 1);
    // 设置顶部搜索
    self.navView = [[ETFoundSerarchNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kStatusAndNavHeight)];
    self.navView.delegate = self;
    [self.view addSubview:self.navView];
    
    self.sectionView = [[NSBundle mainBundle] loadNibNamed:@"ETFoundSectionView" owner:nil options:nil].lastObject;
    self.sectionView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), SCREEN_WIDTH, 98);
    WEAK_SELF(self);
    [self.sectionView setFoundWebViewblock:^(NSString * _Nonnull str) {
        
        STRONG_SELF(self);
        ETHTMLViewController *vc = [[ETHTMLViewController alloc]init];
        vc.url = [NSString stringWithFormat:@"http://str"];
        [self.navigationController pushViewController:vc animated:true];
        
    }];
    [self.view addSubview:self.sectionView];
    
    
    NSMutableArray *data = [NSMutableArray array];
    [data addObject:@"JIBI"];
    [data addObject:@"ET 2.0"];
    [data addObject:@"JIBI"];
    [data addObject:@"ET 2.0"];
    [data addObject:@"宝宝"];
    [data addObject:@"宝宝宝宝"];
    [data addObject:@"宝宝宝宝宝宝"];
    [data addObject:@"宝"];
    
    self.headerView = [[ETFoundSearchCollectionView alloc]init];
    self.headerView.delegate = self;
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 115);
    self.headerView.dataArr = data;
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.detailTab];
    self.detailTab.tableHeaderView = self.headerView;
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        STRONG_SELF(self);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.sectionView.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETFoundSearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETFoundSearchDetailCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 73;
    
}
#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETFoundSearchDetailCell" bundle:nil] forCellReuseIdentifier:@"ETFoundSearchDetailCell"];
    }
    return _detailTab;
}


#pragma mark - ETFoundSerarchNavViewDelegate
- (void)ETFoundSerarchNavViewCancle {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)ETFoundSerarchNavViewTextfiled:(UITextField *)textfield {
    
    self.sectionView.topLb.text = textfield.text;
    self.sectionView.bottomLb.text = [NSString stringWithFormat:@"http://%@",textfield.text];
    
}

#pragma mark - ETFoundSearchCollectionViewDelegate
- (void)ETFoundSearchCollectionViewDelegateClick:(NSString *)str {
    
    self.navView.textfiled.text = str;
    
    self.sectionView.topLb.text = str;
    self.sectionView.bottomLb.text = [NSString stringWithFormat:@"http://%@",str];
    
}

@end
