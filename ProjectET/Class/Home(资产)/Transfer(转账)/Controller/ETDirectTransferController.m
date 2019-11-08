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

@interface ETDirectTransferController ()<UITableViewDelegate,UITableViewDataSource,ETDirectTranAddressCellDelegate,ETDirectCountCellDelegate,ETDirectNormalCellDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSString *countString;

@property (nonatomic,strong) NSString *kgString;
@end

@implementation ETDirectTransferController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"直接转账";
    
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
        
    }];
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
        return cell;
        
    }else if (indexPath.row == 2){
        
        ETDirectLeftCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ETDirectLeftCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        cell.textfiled.placeholder = @"0.098753ETH";
        cell.arrowLb.hidden = NO;
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

#pragma mark - ETDirectTranAddressCellDelegate

- (void)ETDirectTranAddressCellDelegateTextfiled:(UITextField *)textfiled {
    
    self.address = textfiled.text;
    
}

- (void)ETDirectTranAddressCellDelegateAddressClick {
    
    ETMyContactsController *cVC = [ETMyContactsController new];
    [self.navigationController pushViewController:cVC animated:YES];
    
}

#pragma mark - ETDirectCountCellDelegate
- (void)ETDirectCountCellDelegateTextField:(UITextField *)textfiled {
    
    self.countString = textfiled.text;
    
}

- (void)ETDirectCountCellDelegateFullCoinClick {
    
    NSLog(@"ETDirectCountCellDelegateFullCoinClick");
}

#pragma mark - ETDirectNormalCellDelegate

- (void)ETDirectNormalCellDelegateTextField:(UITextField *)textfiled {
    
    self.kgString = textfiled.text;
    
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
    
   
    WEAK_SELF(self);
    [clickBtn bk_whenTapped:^{
        STRONG_SELF(self);
        
        if ([Tools checkStringIsEmpty:self.address]) {
            [KMPProgressHUD showText:@"转账地址不能为空"];
            return;
        }
        
        if ([Tools checkStringIsEmpty:self.countString]) {
            [KMPProgressHUD showText:@"转账数量不能为空"];
            return;
        }
        
        
//        [HSEther hs_sendToAssress:self.address ip:@"https://ropsten.infura.io/v3/bb770b6135ec434e9259072aee28efe0" money:self.countString tokenETH:nil decimal:@"18" currentKeyStore:model.keyStore pwd:model.password gasPrice:nil gasLimit:nil block:^(NSString *hashStr, BOOL suc, HSWalletError error) {
//
//        }];
        [SVProgressHUD showWithStatus:@"正在转账"];
        ETWalletModel *model = [ETWalletManger getCurrentWallet];
        [HSEther ETTest_hs_sendToAssress:self.address money:self.countString tokenETH:nil decimal:@"18" currentKeyStore:model.keyStore pwd:model.password gasPrice:nil gasLimit:nil block:^(NSString *hashStr, BOOL suc, HSWalletError error) {
            
            if (suc) {
                [KMPProgressHUD showProgressWithText:@"转账成功"];
            }else {
                 [KMPProgressHUD showProgressWithText:@"转账失败"];
            }
            
        }];
       
    }];
   
    
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
