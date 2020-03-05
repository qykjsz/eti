//
//  ETSecretImportController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETKeyStoreController.h"
#import "ETScanViewController.h"
#import "ETRootViewController.h"
#import "ETHTMLViewController.h"
// cell
#import "ETCreatYYViewCell.h"
#import "ETCreatWalletInputCell.h"
#import "ETCreatWalletInfoCell.h"

@interface ETKeyStoreController ()<UITableViewDelegate,UITableViewDataSource,ETCreatYYViewCellDelegate,ETCreatWalletInputCellDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSString *secretKey;

@property (nonatomic,strong) NSString *walletName;

@property (nonatomic,strong) NSString *setPassWord;

@property (nonatomic,assign) BOOL isAgree;

@end

@implementation ETKeyStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [right setImage:[UIImage imageNamed:@"zjc_sao"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    self.title = @"Keystore";
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
    
    if (indexPath.row == 0) {
        return 120;
    }else {
        return 49;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ETCreatYYViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatYYViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textView.placeholderText = @"直接复制粘贴钱包Keystore文件内容至输入框。或者通过生产 Keystore内容的二维码，扫描录入。";
        cell.delegate = self;
        if (self.secretKey) {
            cell.textView.text = self.secretKey;
        }
        return  cell;
    }else {
        ETCreatWalletInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatWalletInputCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WEAK_SELF(cell);
        [cell setSecurEntyBlock:^(BOOL flag, NSIndexPath * _Nonnull rowPath) {
           
            STRONG_SELF(cell);
            if (rowPath.row == 2) {
               cell.textfiled.secureTextEntry = !flag;
            }
        }];
        cell.rowPath = indexPath;
        cell.delegate = self;
        if (indexPath.row == 1) {
            cell.titleLb.text = @"钱包名字:";
            cell.hideBtn.hidden = YES;
            cell.textfiled.placeholder = @"请输入您的钱包名称";
        }else {
            cell.titleLb.text = @"Keystore密码:";
            cell.hideBtn.hidden = false;
            cell.textfiled.secureTextEntry = YES;
            cell.textfiled.placeholder = @"请输入密码";
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - ETCreatYYViewCellDelegate
- (void)ETCreatYYViewCellDelegateTextView:(YYTextView *)textView {
    
    self.secretKey = textView.text;
    
}

#pragma mark - ETCreatWalletInputCellDelegate
- (void)ETCreatWalletInputCellDelegateTextfied:(UITextField *)fielde rowPath:(NSIndexPath *)path {
    
    if (path.row == 1) {
        self.walletName = fielde.text;
    }else if (path.row == 2){
        self.setPassWord = fielde.text;
    }
    
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETCreatYYViewCell class] forCellReuseIdentifier:@"ETCreatYYViewCell"];
        [_detailTab registerNib:[UINib nibWithNibName:@"ETCreatWalletInputCell" bundle:nil] forCellReuseIdentifier:@"ETCreatWalletInputCell"];
        [_detailTab registerNib:[UINib nibWithNibName:@"ETCreatWalletInfoCell" bundle:nil] forCellReuseIdentifier:@"ETCreatWalletInfoCell"];
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.tableFooterView = [self footerView];
    }
    return _detailTab;
}

- (UIView *)footerView{
    
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 44)];
    btn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    [btn setTitle:@"开始导入" forState:UIControlStateNormal];
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
    clickBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [backView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(selectBtn.mas_centerY);
        make.left.equalTo(tipsLb.mas_right).offset(5);
        
    }];
    
    UIButton *bottomBtn = [[UIButton alloc]init];
    [bottomBtn setTitle:@"什么是Keystore?" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomBtn setTitleColor:UIColorFromHEX(0x1D57FF, 1) forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(questionClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(btn.mas_bottom).offset(0);
        make.centerX.equalTo(backView.mas_centerX);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
        
    }];
    
    return backView;
    
}


#pragma mark - Action

- (void)clickAction {
    
    if ([self.secretKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [KMPProgressHUD showText:@"请输入Keystore"];
        return;
    }
    
    if ([self.walletName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [KMPProgressHUD showText:@"请输入钱包名字"];
        return;
    }
    
    if ([self.setPassWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [KMPProgressHUD showText:@"请输入原keystore密码"];
        return;
    }
    
    if (!self.isAgree) {
        
        [KMPProgressHUD showText:@"请同意阅读并同意服务及隐私条款"];
        return;
    }
    
    self.view.userInteractionEnabled = NO;

    [SVProgressHUD showWithStatus:@"正在导入"];
    [HSEther hs_importKeyStore:self.secretKey pwd:self.setPassWord block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
        [SVProgressHUD showWithStatus:@"正在导入"];
        self.view.userInteractionEnabled = YES;
        
        if (suc) {
            ETWalletModel *model = [[ETWalletModel alloc]init];
            model.password = self.setPassWord;
            model.walletName = self.walletName;
            model.keyStore = keyStore;
            model.address = address;
            model.mnemonicPhrase = [mnemonicPhrase componentsSeparatedByString:@" "];
//            model.privateKey = [privateKey substringFromIndex:2];
            model.walletType = @"以太坊";
            model.isOpenChat = NO;
            [HTTPTool requestDotNetWithURLString:@"et_import" parameters:@{@"address":address} type:kPOST success:^(id responseObject) {

                [ETWalletManger addWallet:model];

                [KMPProgressHUD showText:@"导入成功"];

                NSMutableArray *arr = WALLET_ARR;
                if (arr.count == 1) {
                    [UIApplication sharedApplication].delegate.window.rootViewController = [ETRootViewController new];
                }else {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }

            } failure:^(NSError *error) {
                 self.view.userInteractionEnabled = YES;
                
            }];

            
        }else {
             self.view.userInteractionEnabled = YES;
            [SVProgressHUD showInfoWithStatus:@"导入失败"];
        }
       
        
    }];
}

- (void)rightAction {
    ETScanViewController *sVC = [ETScanViewController new];
    [sVC setScanBlock:^(NSString * _Nonnull qcodeString) {
        
        self.secretKey = qcodeString;
        [self.detailTab reloadData];
        
    }];
    [self.navigationController pushViewController:sVC animated:YES];
}

- (void)selectAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.isAgree = sender.selected;
    
}

- (void)questionClick {
    ETHTMLViewController *vc = [[ETHTMLViewController alloc]init];
      vc.url = @"https://etoken.etac.io/weburl/help.html?typeid=7";
      vc.title = @"什么是Keystore";
      [self.navigationController pushViewController:vc animated:true];
}
@end
