//
//  ETDirectTransferController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETDirectTransferController.h"
#import "ETDirectTranAddressCell.h"
#import "ETMyContactsController.h"

#import "ETDirectCountCell.h"
#import "ETDirectLeftCell.h"
#import "ETDirectNormalCell.h"
#import "ETHomeModel.h"
#import "ETTransferGasView.h"
#import "ETTransferGasModel.h"

@interface ETDirectTransferController ()<UITableViewDelegate,UITableViewDataSource,ETDirectTranAddressCellDelegate,ETDirectCountCellDelegate,ETDirectNormalCellDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSString *countString;

@property (nonatomic,strong) NSString *kgString;

@property (nonatomic,strong) ETHomeModel *model;

@property (nonatomic,strong) NSString *leftString;

@property (nonatomic,strong) NSString *totalString;

@property (nonatomic,assign) NSInteger gasValue;

@property (nonatomic,assign) CGFloat tranGasValue;

@property (nonatomic,strong) NSString *toToken;

@property (nonatomic,strong) NSString *gaslimit;

@property (nonatomic,strong) NSString *decimalString;

@property (nonatomic,strong) ETTransferGasView *gasView;


@end

@implementation ETDirectTransferController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self kuanggongRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"直接转账";
    self.coinNameString = @"ETH";
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
        
    }];
    
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"et_home" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
        
        self.model = [ETHomeModel mj_objectWithKeyValues:responseObject];
        if (self.model.data.glod.count != 0) {
            glodData *data = self.model.data.glod[0];
            self.coinNameString = data.name;
            self.leftString = data.number;
            [self.detailTab reloadData];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    [self kuanggongRequest];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        ETDirectTranAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETDirectTranAddressCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        if (self.address) {
            cell.textfield.text = self.address;
        }
        return cell;
        
    }else if (indexPath.row == 1){
        
        ETDirectCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETDirectCountCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textfiled.keyboardType = UIKeyboardTypeDecimalPad;
        cell.delegate = self;
        if (self.coinNameString) {
            [cell.coninBtn setTitle:[NSString stringWithFormat:@"%@ >",self.coinNameString] forState:UIControlStateNormal];
        }
        if (self.countString) {
            cell.textfiled.text = self.countString;
        }
        return cell;
        
    }else if (indexPath.row == 2){
        
        ETDirectLeftCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ETDirectLeftCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.leftString) {
            cell.countLb.text = [NSString stringWithFormat:@"剩余%@%@",self.leftString,self.coinNameString];
        }
        return cell;
        
    }else if(indexPath.row == 3) {
        
        ETDirectNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETDirectNormalCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLb.text = @"备注";
        cell.textfiled.placeholder = @"请输入备注信息";
        cell.arrowLb.hidden = YES;
        return cell;
        
    }else {
        
        ETDirectNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETDirectNormalCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLb.text = @"矿工费";
        cell.delegate = self;
        cell.textfiled.placeholder = @"请滑动选择矿工费";
        cell.arrowLb.hidden = NO;
        cell.textfiled.enabled = NO;
        
        if (self.tranGasValue) {
            cell.textfiled.text = [NSString stringWithFormat:@"%f%@",self.tranGasValue,@"ETH"];
        }else {
            cell.textfiled.text = nil;
        }
        return cell;
        
    }
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 80;
    }else if (indexPath.row == 2){
        return 35;
    }
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 4) {
        

        [self kuanggongRequest];
        [[UIApplication sharedApplication].keyWindow addSubview:self.gasView];
       
    }
    

}

- (void)kuanggongRequest {
    
    [HTTPTool requestDotNetWithURLString:@"givecharge" parameters:nil type:kPOST success:^(id responseObject) {
        
        
        ETTransferGasModel *model = [ETTransferGasModel mj_objectWithKeyValues:responseObject];
        
        
        self.gasView = [[ETTransferGasView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        WEAK_SELF(self);
        [self.gasView setSliderBlcok:^(CGFloat gas, CGFloat transfergas,NSString *gaslimit) {
            STRONG_SELF(self);
            self.tranGasValue = transfergas;
            self.gasValue = gas;
            self.gaslimit = gaslimit;
            [self.detailTab reloadData];
            NSLog(@"%f,%f",transfergas,gas);
        }];
        self.gasView.coinName = self.coinNameString;
        
        TransferGasData *data1 = model.data[0];
        TransferGasData *data2 = model.data[1];
        if ([data1.name isEqualToString:self.coinNameString]) {
            self.gasView.data = data1;
            self.gaslimit = data1.gasmin;
            self.gasValue = [data1.gweidefault integerValue];
            self.tranGasValue = [data1.gasmin floatValue] * self.gasValue / 1000000000;
            [self.detailTab reloadData];
        }else {
            self.gasView.data = data2;
            self.gaslimit = data2.gasmin;
            self.gasValue = [data2.gweidefault integerValue];
            self.tranGasValue = [data2.gasmin floatValue] * self.gasValue / 1000000000;
            [self.detailTab reloadData];
        }
        
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - ETDirectTranAddressCellDelegate

- (void)ETDirectTranAddressCellDelegateTextfiled:(UITextField *)textfiled {
    
    self.address = textfiled.text;
    
}

- (void)ETDirectTranAddressCellDelegateAddressClick {
    
    ETMyContactsController *cVC = [ETMyContactsController new];
    WEAK_SELF(self);
    [cVC setAddressBlcok:^(NSString * _Nonnull address) {
       
        STRONG_SELF(self);
        self.address = address;
        [self.detailTab reloadData];
        
    }];
    
    [self.navigationController pushViewController:cVC animated:YES];
    
}

#pragma mark - ETDirectCountCellDelegate
- (void)ETDirectCountCellDelegateTextField:(UITextField *)textfiled {
    
    self.countString = textfiled.text;
    
}

- (void)ETDirectCountCellDelegateFullCoinClick {
    
    if (self.model) {
        for (int i = 0; i<self.model.data.glod.count; i++) {
            
            glodData *data = self.model.data.glod[i];
            if ([data.name isEqualToString:self.coinNameString]) {
                self.countString = data.number;
                [self.detailTab reloadData];
            }
        }
    }
}

- (void)getHeYueInfo {
    
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"et_home" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled = YES;
       
        self.model = [ETHomeModel mj_objectWithKeyValues:responseObject];
        
        for (glodData *data in self.model.data.glod) {
            if ([data.name isEqualToString:self.coinNameString]) {
                self.coinNameString = data.name;
                self.leftString = data.number;
                self.toToken = data.address;
                self.decimalString = data.decimal;
                self.gaslimit = nil;
                self.tranGasValue = 0;
                self.countString = @"";
                [self.detailTab reloadData];
                break;
            }
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled = YES;
    }];
}

- (void)ETDirectCountCellDelegateCoinClick {
    
    self.view.userInteractionEnabled = NO;
    [SVProgressHUD showWithStatus:@"请稍等"];
  
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"et_home" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
        
          [SVProgressHUD dismiss];
         self.view.userInteractionEnabled = YES;
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

        self.model = [ETHomeModel mj_objectWithKeyValues:responseObject];
        
        for (glodData *data in self.model.data.glod) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:data.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.coinNameString = data.name;
                self.leftString = data.number;
                self.toToken = data.address;
                self.decimalString = data.decimal;
                self.gaslimit = nil;
                self.tranGasValue = 0;
                self.countString = @"";
                [self.detailTab reloadData];
            }];
            
            [alter addAction:action];
            
        }
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alter addAction:action];
        [self.navigationController presentViewController:alter animated:YES completion:nil];
        
    } failure:^(NSError *error) {
          [SVProgressHUD dismiss];
         self.view.userInteractionEnabled = YES;
    }];
   
    
   
    
    
}

#pragma mark - ETDirectNormalCellDelegate

- (void)ETDirectNormalCellDelegateTextField:(UITextField *)textfiled {
    
    self.kgString = textfiled.text;
    
}

- (void)virferimAciton {
    
    [SVProgressHUD showWithStatus:@"正在转账"];
    [HTTPTool requestDotNetWithURLString:@"et_node" parameters:nil type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        [KMPProgressHUD dismissProgress];
        NSString *urlString = responseObject[@"data"];
        NSLog(@"%@",urlString);
        
        //                [SVProgressHUD showWithStatus:@"正在转账"];
        //                ETWalletModel *model = [ETWalletManger getCurrentWallet];
        //                [HSEther ETTest_hs_sendToAssress:self.address money:self.countString tokenETH:self.toToken decimal:@"18" currentKeyStore:model.keyStore pwd:model.password gasPrice:[NSString stringWithFormat:@"%zd",self.gasValue] gasLimit:self.gaslimit block:^(NSString *hashStr, BOOL suc, HSWalletError error) {
        //
        //                    if (suc) {
        //                        [KMPProgressHUD showProgressWithText:@"转账成功"];
        //                    }else {
        //                        [KMPProgressHUD showProgressWithText:@"转账失败"];
        //                    }
        //
        //                }];0xa51c50c880d389b5bbd1c76308d3b544f54f39a4
        [SVProgressHUD showWithStatus:@"正在转账"];
        if ([self.coinNameString isEqualToString:@"ETH"]) {
            self.toToken = nil;
            self.decimalString = @"18";
        }
        ETWalletModel *model = [ETWalletManger getCurrentWallet];
        [HSEther hs_sendToAssress:self.address ip:urlString money:self.countString tokenETH:self.toToken decimal:self.decimalString currentKeyStore:model.keyStore pwd:model.password gasPrice:[NSString stringWithFormat:@"%zd",self.gasValue] gasLimit:self.gaslimit block:^(NSString *hashStr, BOOL suc, HSWalletError error) {
            
            if (suc) {
                //                            [SVProgressHUD showWithStatus:@"转账成功"];
                [KMPProgressHUD showText:@"转账成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
                
            }else {
                [KMPProgressHUD showText:@"转账失败"];
            }
        }];
        
        
    } failure:^(NSError *error) {
        [KMPProgressHUD dismissProgress];
        self.view.userInteractionEnabled = YES;
    }];
    
}

- (void)testAction {
    
    //  判断币种是否允许被转出
            [SVProgressHUD showWithStatus:@"正在加载"];
            [HTTPTool requestDotNetWithURLString:@"et_transaction" parameters:@{@"name":self.coinNameString} type:kPOST success:^(id responseObject) {
                [SVProgressHUD dismiss];
                self.view.userInteractionEnabled = YES;
                if ([Tools checkStringIsEmpty:self.address]) {
                    [SVProgressHUD showInfoWithStatus:@"转账地址不能为空"];
                    return;
                }
    
                if ([Tools checkStringIsEmpty:self.countString]) {
                    [SVProgressHUD showInfoWithStatus:@"转账数量不能为空"];
                    return;
                }
    
    
                if ([Tools checkStringIsEmpty:self.gaslimit]) {
                    [SVProgressHUD showInfoWithStatus:@"矿工费不能为空"];
                    return;
                }
                
                
                
                UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"请输入密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                
                //添加一个取消按钮
                [alter addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
                
                [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    
                    textField.placeholder = @"请输入密码";
                    textField.secureTextEntry = YES;
                    
                }];
         
               
                
                [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    ETWalletModel *model = [ETWalletManger getCurrentWallet];
                    UITextField *envirnmentNameTextField = alter.textFields.firstObject;
                    if (![model.password isEqualToString:envirnmentNameTextField.text]) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [SVProgressHUD showInfoWithStatus:@"密码不正确"];
                        });
                    }else {
                        [self virferimAciton];
                    }
                }]];
                
                
                
                [self.navigationController presentViewController:alter animated:YES completion:nil];
                
            } failure:^(NSError *error) {
                [KMPProgressHUD dismissProgress];
                self.view.userInteractionEnabled = YES;
            }];
}

#pragma Mark - View
- (UIView *)footerView {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 150, SCREEN_WIDTH - 30, 44)];
    [clickBtn setTitle:@"确认" forState:UIControlStateNormal];
    [clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    clickBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    clickBtn.clipsToBounds = YES;
    clickBtn.layer.cornerRadius = 5;
    
    [clickBtn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:clickBtn];
    return view;
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETDirectTranAddressCell" bundle:nil] forCellReuseIdentifier:@"ETDirectTranAddressCell"];
        [_detailTab registerNib:[UINib nibWithNibName:@"ETDirectCountCell" bundle:nil] forCellReuseIdentifier:@"ETDirectCountCell"];
        [_detailTab registerNib:[UINib nibWithNibName:@"ETDirectLeftCell" bundle:nil] forCellReuseIdentifier:@"ETDirectLeftCell"];
        [_detailTab registerNib:[UINib nibWithNibName:@"ETDirectNormalCell" bundle:nil] forCellReuseIdentifier:@"ETDirectNormalCell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
        _detailTab.tableFooterView = [self footerView];
    }
    return _detailTab;
}
@end
