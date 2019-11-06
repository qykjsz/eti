//
//  ETCreatWalletViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETCoinMainViewController.h"
#import "ETCreatWalletCell.h"
#import "ETRememberCardController.h"
#import "ETColdWalletViewController.h"
#import "ETKeyStoreController.h"
#import "ETCreatMyWalletViewController.h"
#import "ETChooseWalletcell.h"
#import "ETCoinListViewController.h"

@interface ETCoinMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@end

@implementation ETCoinMainViewController

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
    
    [self pagelayout];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else {
        return 3;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETCreatWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatWalletCell"];
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                cell.titleLb.text = @"我有钱包";
                cell.iconImage.image = [UIImage imageNamed:@"dc_qb"];
                cell.subTtitlLb.text = @"导入钱包";
            }
                break;
            case 1:{
                cell.titleLb.text = @"我没有钱包";
                cell.iconImage.image = [UIImage imageNamed:@"dc_no"];
                cell.subTtitlLb.text = @"创建钱包";
            }
                break;
            case 2:{
                cell.titleLb.text = @"访客模式";
                cell.iconImage.image = [UIImage imageNamed:@"dc_fk"];
                cell.subTtitlLb.text = @"使用固定账号登录";
            }
                break;
            default:
                break;
        }
        return cell;
    }else {
        ETChooseWalletcell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETChooseWalletcell"];
        cell.titleLb.text = @"以太坊";
        cell.iconImage.image = [UIImage imageNamed:@"dc_eth"];
        return  cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                ETCoinListViewController *sVC = [ETCoinListViewController new];
                [self.navigationController pushViewController:sVC animated:YES];
            }
                break;
            case 1: {
                [KMPProgressHUD showText:@"暂未开放"];
            }
                break;
            case 2: {
                ETColdWalletViewController *cVC = [ETColdWalletViewController new];
                [self.navigationController pushViewController:cVC animated:YES];
            }
                break;
            case 3: {
                ETRememberCardController *rVC = [ETRememberCardController new];
                [self.navigationController pushViewController:rVC animated:YES];
            }
                break;
            case 4: {
                ETKeyStoreController *kVC = [ETKeyStoreController new];
                [self.navigationController pushViewController:kVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }else {
        
        ETCreatMyWalletViewController *cVC = [ETCreatMyWalletViewController new];
        [self.navigationController pushViewController:cVC animated:YES];
        
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    backView.backgroundColor = UIColor.whiteColor;
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColorFromHEX(0x000000, 1);
    [backView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(backView.mas_left).offset(15);
        make.centerY.equalTo(backView.mas_centerY);
        
    }];
    
    if (section == 0) {
        titleLb.text = @"当前底层";
    }else {
        titleLb.text = @"你是否有钱包？";
    }
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (void)pagelayout {
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        
    }];
    
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"选择底层";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(topImage.mas_top).offset(20);
        
    }];
    
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImage.mas_bottom).offset(-35);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
}


#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETCreatWalletCell class] forCellReuseIdentifier:@"ETCreatWalletCell"];
        [_detailTab registerClass:[ETChooseWalletcell class] forCellReuseIdentifier:@"ETChooseWalletcell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
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
