//
//  ETSecretImportController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETSecretImportController.h"
#import "ETScanViewController.h"
#import "ETRootViewController.h"
#import "ETHTMLViewController.h"
// cell
#import "ETCreatYYViewCell.h"
#import "ETCreatWalletInputCell.h"
#import "ETCreatWalletInfoCell.h"

@interface ETSecretImportController ()<UITableViewDelegate,UITableViewDataSource,ETCreatYYViewCellDelegate,ETCreatWalletInputCellDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSString *secretKey;

@property (nonatomic,strong) NSString *walletName;

@property (nonatomic,strong) NSString *setPassWord;

@property (nonatomic,strong) NSString *comfirmPassWord;

@property (nonatomic,assign) BOOL isAgree;

@end

@implementation ETSecretImportController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [right setImage:[UIImage imageNamed:@"zjc_sao"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    self.title = @"私钥导入";
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
    
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
        cell.textView.placeholderText = @"请输入明文私钥";
        if (self.secretKey) {
            cell.textView.text = self.secretKey;
        }
        cell.delegate = self;
        return  cell;
    }else if (indexPath.row == 1) {
        ETCreatWalletInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatWalletInfoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLb.text = @"钱包体系";
        cell.subTitle.text = @"以太坊底层";
        return cell;
    }else {
        ETCreatWalletInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatWalletInputCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rowPath = indexPath;
        cell.delegate = self;
        
        WEAK_SELF(cell);
        [cell setSecurEntyBlock:^(BOOL flag, NSIndexPath * _Nonnull rowPath) {
            
            STRONG_SELF(cell);
            if (rowPath.row == 3) {
                cell.textfiled.secureTextEntry = !flag;
            }
            
            ETCreatWalletInputCell *comfirmCell = (ETCreatWalletInputCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
            comfirmCell.textfiled.secureTextEntry = !flag;
        }];
        switch (indexPath.row) {
            case 2:{
                cell.titleLb.text = @"钱包名字:";
                cell.hideBtn.hidden = YES;
                cell.textfiled.placeholder = @"请输入您的钱包名称";
            }
                break;
            case 3:{
                cell.titleLb.text = @"设置密码:";
                cell.hideBtn.hidden = false;
                cell.textfiled.secureTextEntry = YES;
                cell.textfiled.placeholder = @"请输入您的钱包密码";
            }
                break;
            case 4:{
                cell.titleLb.text = @"确认密码:";
                cell.hideBtn.hidden = true;
                cell.textfiled.secureTextEntry = YES;
                cell.textfiled.placeholder = @"请再次输入您的钱包密码";
            }
                break;
            case 5:{
                cell.titleLb.text = @"提示信息:";
                cell.hideBtn.hidden = true;
                cell.textfiled.placeholder = @"可不填";
            }
                break;
            default:
                break;
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

- (void)ETCreatYYViewCellDelegateSecertClick {
    
}

#pragma mark - ETCreatWalletInputCellDelegate
- (void)ETCreatWalletInputCellDelegateTextfied:(UITextField *)fielde rowPath:(NSIndexPath *)path {
    
    if (path.row == 2) {
        self.walletName = fielde.text;
    }else if (path.row == 3) {
        self.setPassWord = fielde.text;
    }else if (path.row == 4) {
        self.comfirmPassWord = fielde.text;
    }
}

- (void)ETCreatWalletInputCellDelegateTextfiedSecuentry:(BOOL)isSecruty {
    
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
    [bottomBtn setTitle:@"什么是私钥?" forState:UIControlStateNormal];
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
        [KMPProgressHUD showText:@"请输入私钥"];
        return;
    }
    
    if ([self.walletName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [KMPProgressHUD showText:@"请输入钱包名字"];
        return;
    }
    
    if ([self.setPassWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [KMPProgressHUD showText:@"请输入密码"];
        return;
    }
    
    if ([self.comfirmPassWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [KMPProgressHUD showText:@"请输入确认密码"];
        return;
    }
    
    if (![self.setPassWord isEqualToString:self.comfirmPassWord]) {
        [KMPProgressHUD showText:@"两次密码不一致,请重新输入"];
        return;
    }
    
    
    if (!self.isAgree) {
        
        [KMPProgressHUD showText:@"请同意阅读并同意服务及隐私条款"];
        return;
    }
    
    self.view.userInteractionEnabled = NO;
    [SVProgressHUD showWithStatus:@"正在导入"];
    [HSEther hs_importWalletForPrivateKey:self.secretKey pwd:self.setPassWord block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
        self.view.userInteractionEnabled = YES;
        if (suc) {
            ETWalletModel *model = [[ETWalletModel alloc]init];
            model.password = self.setPassWord;
            model.walletName = self.walletName;
            model.keyStore = keyStore;
            model.address = address;
            model.mnemonicPhrase = [mnemonicPhrase componentsSeparatedByString:@" "];
            
            model.privateKey = [privateKey substringFromIndex:2];
            model.walletType = @"以太坊";
            [SVProgressHUD showWithStatus:@"正在导入"];
            [HTTPTool requestDotNetWithURLString:@"et_import" parameters:@{@"address":address} type:kPOST success:^(id responseObject) {
                self.view.userInteractionEnabled = YES;
                [ETWalletManger addWallet:model];
                
                [KMPProgressHUD showText:@"导入成功"];
                
                NSMutableArray *arr = WALLET_ARR;
//                for (ETWalletModel *tempModel in arr) {
//                    tempModel.isCurrentWallet = false;
//                    if ([tempModel.address isEqualToString:model.address]) {
//                        tempModel.isCurrentWallet = YES;
//                    }
//                }
//
//                NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WalletData.data"];
//                [NSKeyedArchiver archiveRootObject:arr toFile:file];
                
                if (arr.count == 1) {
                    [UIApplication sharedApplication].delegate.window.rootViewController = [ETRootViewController new];
                }else {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                
            } failure:^(NSError *error) {
                self.view.userInteractionEnabled = YES;
                [SVProgressHUD showInfoWithStatus:@"导入失败"];
            }];
            
           
            
        }else {
            self.view.userInteractionEnabled = YES;
            [SVProgressHUD showInfoWithStatus:@"导入失败"];
        }
        
    }];
    
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(40 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [SVProgressHUD dismiss];
                 [SVProgressHUD showInfoWithStatus:@"导入失败,请检查私钥"];
                self.view.userInteractionEnabled = YES;
            });
    

    
    
    
    
    
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
     vc.url = @"https://etoken.etac.io/weburl/help.html?typeid=6";
     vc.title = @"什么是私钥";
     [self.navigationController pushViewController:vc animated:true];
}


@end
