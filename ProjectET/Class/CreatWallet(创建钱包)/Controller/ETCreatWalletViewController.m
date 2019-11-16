//
//  ETCreatWalletViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETCreatWalletViewController.h"
#import "ETCreatWalletCell.h"
#import "ETSecretImportController.h"
#import "ETRememberCardController.h"
#import "ETColdWalletViewController.h"
#import "ETKeyStoreController.h"
#import "ETCreatMyWalletViewController.h"

#import "ETCoinMainViewController.h"

@interface ETCreatWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@end

@implementation ETCreatWalletViewController

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
        return 5;
    }else {
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETCreatWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatWalletCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                cell.titleLb.text = @"私钥导入";
                cell.iconImage.image = [UIImage imageNamed:@"cj_sy_01"];
                cell.subTtitlLb.text = @"通过输入明文私钥或扫描二维码进行导入";
                cell.backGrayView.hidden = YES;
            }
                break;
            case 1:{
                cell.titleLb.text = @"助记词导入";
                cell.iconImage.image = [UIImage imageNamed:@"cj_zjc_04"];
                cell.subTtitlLb.text = @"通过输入助记词或扫描二维码进行导入";
                cell.backGrayView.hidden = YES;
            }
                break;
            case 2:{
                cell.titleLb.text = @"Keystore导入";
                cell.iconImage.image = [UIImage imageNamed:@"cj_key_05"];
                cell.subTtitlLb.text = @"输入keystore文件内容或扫描二维码进行导入";
                cell.backGrayView.hidden = YES;
            }
                break;
            case 3:{
                cell.titleLb.text = @"观察钱包";
                cell.iconImage.image = [UIImage imageNamed:@"cj_fc_02"];
                cell.subTtitlLb.text = @"无需导入私钥，输入账号或者对应公钥即可导入";
                cell.backGrayView.hidden = NO;
            }
                break;
            case 4:{
                cell.titleLb.text = @"冷钱包";
                cell.iconImage.image = [UIImage imageNamed:@"cj_lqb_03"];
                cell.subTtitlLb.text = @"离线导入并保持与网络隔绝，确保私钥永不触网";
                cell.backGrayView.hidden = NO;
            }
                break;
            default:
                break;
        }
    }else {
        cell.titleLb.text = @"我没有钱包";
        cell.iconImage.image = [UIImage imageNamed:@"cj_no_06"];
        cell.subTtitlLb.text = @"创建钱包";
        cell.backGrayView.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                ETSecretImportController *sVC = [ETSecretImportController new];
                [self.navigationController pushViewController:sVC animated:YES];
            }
                break;
            case 1: {
                ETRememberCardController *rVC = [ETRememberCardController new];
                [self.navigationController pushViewController:rVC animated:YES];
                
            }
                break;
            case 2: {
                ETKeyStoreController *kVC = [ETKeyStoreController new];
                [self.navigationController pushViewController:kVC animated:YES];

            }
                break;
            case 3: {
                [KMPProgressHUD showText:@"暂未开放"];
            }
                break;
            case 4: {
                [KMPProgressHUD showText:@"暂未开放"];
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
        titleLb.text = @"导入钱包";
    }else {
        titleLb.text = @"创建钱包";
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
        make.height.mas_equalTo(kStatusAndNavHeight+20);
    }];
    
    UIButton *popBtn = [[UIButton alloc]init];
    [popBtn setImage:[UIImage imageNamed:@"fh_icon_white"] forState:UIControlStateNormal];
    [popBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [popBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [popBtn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:popBtn];
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImage.mas_top).offset(iPhoneBang?kStatusBarHeight-10:kStatusBarHeight);
        make.width.height.equalTo(@44);
        
    }];
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"创建钱包";
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
        [_detailTab registerClass:[ETCreatWalletCell class] forCellReuseIdentifier:@"ETCreatWalletCell"];
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
