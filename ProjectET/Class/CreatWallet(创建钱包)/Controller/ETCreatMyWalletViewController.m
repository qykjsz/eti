//
//  ETSecretImportController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETCreatMyWalletViewController.h"
#import "ETRootViewController.h"
#import "backUpMoneyViewController.h"

// cell
#import "ETCreatYYViewCell.h"
#import "ETCreatWalletInputCell.h"

#import "ETWalletModel.h"

#import "AppDelegate.h"

@interface ETCreatMyWalletViewController ()<UITableViewDelegate,UITableViewDataSource,ETCreatWalletInputCellDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSString *nameString;

@property (nonatomic,strong) NSString *passwordString;

@property (nonatomic,strong) NSString *comfirmString;

@property (nonatomic,assign) BOOL isComfirm;

@property (nonatomic,assign) BOOL isOpen;

@end

@implementation ETCreatMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isOpen = YES;
    self.title = @"创建钱包";
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 49;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    

        ETCreatWalletInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatWalletInputCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rowPath = indexPath;
        cell.delegate = self;
        switch (indexPath.row) {
            case 0:{
                cell.titleLb.text = @"设置钱包名字:";
                cell.hideBtn.hidden = YES;
                cell.textfiled.placeholder = @"请输入钱包名";
            }
                break;
            case 1:{
                cell.titleLb.text = @"设置密码:";
                cell.hideBtn.hidden = false;
                cell.textfiled.placeholder = @"请输入不少于8位数的密码";
                cell.textfiled.secureTextEntry = self.isOpen;
            }
                break;
            case 2:{
                cell.titleLb.text = @"确认密码:";
                cell.hideBtn.hidden = true;
                cell.textfiled.placeholder = @"确认密码";
                cell.textfiled.secureTextEntry = self.isOpen;
            }
                break;
            default:
                break;
        }
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - ETCreatWalletInputCellDelegate
- (void)ETCreatWalletInputCellDelegateTextfied:(UITextField *)fielde rowPath:(NSIndexPath *)path {
    
    if (path.row == 0) {
        self.nameString = fielde.text;
    }else if (path.row == 1){
        self.passwordString = fielde.text;
    }else {
        self.comfirmString = fielde.text;
    }
}

- (void)ETCreatWalletInputCellDelegateTextfiedSecuentry:(BOOL)isSecruty {
    
    self.isOpen = !isSecruty;
    [self.detailTab reloadData];
    
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETCreatWalletInputCell" bundle:nil] forCellReuseIdentifier:@"ETCreatWalletInputCell"];
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.tableFooterView = [self footerView];
    }
    return _detailTab;
}

- (UIView *)footerView{
    
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    backView.userInteractionEnabled = YES;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 44)];
    btn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    [btn setTitle:@"创建钱包" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    
    UIButton *selectBtn = [[UIButton alloc]init];
    [selectBtn setImage:[UIImage imageNamed:@"qb_weix"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"qb_xuan"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(backView.mas_top);
        make.width.height.mas_equalTo(30);
        
    }];
    
    UILabel *tipsLb = [[UILabel alloc]init];
    tipsLb.text = @"我已仔细阅读并同意";
    tipsLb.textColor = UIColorFromHEX(0x999999, 1);
    tipsLb.font = [UIFont systemFontOfSize:12];
    [backView addSubview:tipsLb];
    [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(selectBtn.mas_centerY);
        make.left.equalTo(selectBtn.mas_right);
        
    }];
    
    UIButton *clickBtn = [[UIButton alloc]init];
    [clickBtn setTitle:@"服务及隐私条款" forState:UIControlStateNormal];
    [clickBtn setTitleColor:UIColorFromHEX(0x1D57FF, 1) forState:UIControlStateNormal];
    clickBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(selectBtn.mas_centerY);
        make.left.equalTo(tipsLb.mas_right).offset(5);
        
    }];
    
    UILabel *tipsLbTwo = [[UILabel alloc]init];
    tipsLbTwo.text = @"·我已仔细阅读并同意 服务及隐私条款";
    tipsLbTwo.textColor = UIColorFromHEX(0x999999, 1);
    tipsLbTwo.font = [UIFont systemFontOfSize:12];
    [backView addSubview:tipsLbTwo];
    [tipsLbTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(selectBtn.mas_right);
        make.top.equalTo(tipsLb.mas_bottom).offset(10);
        
    }];
    
    UILabel *tipsLbThree = [[UILabel alloc]init];
    tipsLbThree.text = @"·App不存储密码，也无法帮您找回，请务必牢";
    tipsLbThree.textColor = UIColorFromHEX(0x999999, 1);
    tipsLbThree.font = [UIFont systemFontOfSize:12];
    [backView addSubview:tipsLbThree];
    [tipsLbThree mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(selectBtn.mas_right);
        make.top.equalTo(tipsLbTwo.mas_bottom).offset(10);
        
    }];
    
    return backView;
    
}


#pragma mark - Action

- (void)clickAction {
    
    if ([self.nameString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 ) {
        [KMPProgressHUD showText:@"钱包名不能为空"];
        return;
    }
    
    if ([self.passwordString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 ) {
        [KMPProgressHUD showText:@"密码不能为空"];
        return;
    }
    
    if (self.passwordString.length < 8) {
        [KMPProgressHUD showText:@"密码不能少于8位数"];
        return;
    }
    
    if ([self.comfirmString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 ) {
        [KMPProgressHUD showText:@"确认密码不能为空"];
        return;
    }
    
    if (![self.passwordString isEqualToString:self.comfirmString]) {
        [KMPProgressHUD showText:@"两次密码不一致"];
        return;
    }
    
    if (!self.isComfirm) {
        [KMPProgressHUD showText:@"请同意服务条款"];
        return;
    }
    
    NSMutableArray *arr = WALLET_ARR;
    NSLog(@"%@",arr);
    
    [KMPProgressHUD showProgressWithText:@"正在创建钱包"];
    self.view.userInteractionEnabled = NO;
    [HSEther hs_createWithPwd:self.passwordString block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey) {
        self.view.userInteractionEnabled = YES;
        [KMPProgressHUD showText:@"创建成功"];
        ETWalletModel *model = [[ETWalletModel alloc]init];
        model.password = self.passwordString;
        model.walletName = self.nameString;
        model.keyStore = keyStore;
        model.address = address;
        model.mnemonicPhrase = [mnemonicPhrase componentsSeparatedByString:@" "];
        model.privateKey = privateKey;
        model.walletType = @"以太坊";
        NSMutableArray *arr = WALLET_ARR;
        if (arr == nil) {
            arr = [NSMutableArray array];
        }
        
        if (arr.count == 0) {
            model.isCurrentWallet = YES;
        }
        [arr addObject:model];

        //保存登录信息
        NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WalletData.data"];
        [NSKeyedArchiver archiveRootObject:arr toFile:file];
        
     //   [UIApplication sharedApplication].delegate.window.rootViewController = [[ETRootViewController alloc]init];
        [HTTPTool requestDotNetWithURLString:@"et_import" parameters:@{@"address":address} type:kPOST success:^(id responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSError *error) {
            
        }];
        
        backUpMoneyViewController *backVC = [backUpMoneyViewController new];
        backVC.model = model;
        [self.navigationController pushViewController:backVC animated:YES];
        
    }];

}

- (void)selectAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.isComfirm = sender.selected;
    
}
@end
