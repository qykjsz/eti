//
//  ETCreatWalletViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETCoinListViewController.h"
#import "ETCreatWalletCell.h"
#import "ETSecretImportController.h"
#import "ETRememberCardController.h"
#import "ETColdWalletViewController.h"
#import "ETKeyStoreController.h"
#import "ETCreatMyWalletViewController.h"
#import "ETCreatWalletViewController.h"
#import "ETChooseWalletcell.h"

@interface ETCoinListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSArray *iconNameArr;

@property (nonatomic,strong) NSArray *coninNameArr;

@property (nonatomic,strong) NSArray *coninSubNameArr;

@end

@implementation ETCoinListViewController

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
    
    self.iconNameArr = @[@"qbgl_eos_xz",@"qbgl_eth_xz",@"qbgl_iost_xz",@"qbgl_tron_xz",@"qbgl_binance_xz",@"qbgl_bos_xz",@"qbgl_cosmos_xz",@"qbgl_moac_xz"];
    self.coninNameArr = @[@"EOS",@"以太坊",@"IOST",@"Tron",@"BINANCE",@"BOS",@"COSMOS",@"墨客"];
    self.coninSubNameArr = @[@"EOS底层",@"以太坊底层",@"IOST底层",@"Tron底层",@"Binance底层",@"BOS底层",@"COSMOS底层",@"墨客底层"];
    [self pagelayout];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    ETChooseWalletcell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETChooseWalletcell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.subTtitlLb.font = [UIFont systemFontOfSize:14];
    cell.subTtitlLb.textColor = UIColorFromHEX(0x000000, 1);
    cell.titleLb.text = self.coninNameArr[indexPath.row];
    cell.subTtitlLb.text = self.coninSubNameArr[indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:self.iconNameArr[indexPath.row]];
    return  cell;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    backView.backgroundColor = UIColor.whiteColor;
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
     self.coninSubNameArr = @[@"EOS底层",@"以太坊底层",@"IOST底层",@"Tron底层",@"Binance底层",@"BOS底层",@"COSMOS底层",@"墨客底层"];
    NSString *name = self.coninSubNameArr[indexPath.row];
    if (indexPath.row == 1) {
        
        if (self.isCreatWallet) {
            ETCreatWalletViewController *cVC = [ETCreatWalletViewController new];
            [self.navigationController pushViewController:cVC animated:YES];
        }else {
            if (self.block) {
                self.block(name);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
       
    }else {
        [KMPProgressHUD showText:@"暂未开放"];
    }
    
    
}

- (void)pagelayout {
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kStatusAndNavHeight + 20);
        
    }];
    
    UIButton *popBtn = [[UIButton alloc]init];
    [popBtn setImage:[UIImage imageNamed:@"fh_icon_white"] forState:UIControlStateNormal];
    [popBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [popBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [popBtn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:popBtn];
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImage.mas_top).offset(kStatusBarHeight);
        make.width.height.equalTo(@44);
        
    }];
    
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"请选择底层";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.centerY.equalTo(popBtn.mas_centerY);
        
    }];
    
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(kStatusAndNavHeight);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
}

- (void)popAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
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
