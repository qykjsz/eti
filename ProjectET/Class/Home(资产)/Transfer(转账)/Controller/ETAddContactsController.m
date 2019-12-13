//
//  ETAddContactsController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETAddContactsController.h"
#import "ETAddContactsCell.h"
#import "ETScanViewController.h"
#import "ETCoinListViewController.h"
#import "UUID.h"
@interface ETAddContactsController ()<UITableViewDelegate,UITableViewDataSource,ETAddContactsCellDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSString *nameString;

@property (nonatomic,strong) NSString *backUpString;

@property (nonatomic,strong) NSString *bottomAddress;

@property (nonatomic,strong) NSString *walletAddress;

@end



@implementation ETAddContactsController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建联系人";
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    
    
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETAddContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETAddContactsCell"];
    cell.delegate = self;
    cell.rowPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.titleLb.text = @"名字";
        cell.textfiled.placeholder = @"请输入名字";
        cell.arrowImage.hidden = true;
        cell.scanBtn.hidden = true;
        if (self.nameString) {
            cell.textfiled.text = self.nameString;
        }
        if (self.model != nil) {
            self.nameString = self.model.name;
            cell.textfiled.text = self.model.name;
        }
    }else if (indexPath.row == 1) {
        cell.titleLb.text = @"备注";
        cell.textfiled.placeholder = @"选填";
        cell.arrowImage.hidden = true;
        cell.scanBtn.hidden = true;
        if (self.backUpString) {
            cell.textfiled.text = self.backUpString;
        }
        
        if (self.model != nil) {
            cell.textfiled.text = self.model.remarks;
            self.backUpString = self.model.remarks;
        }
    }else if (indexPath.row == 2) {
        cell.titleLb.text = @"钱包底层";
        cell.arrowImage.hidden = false;
        cell.scanBtn.hidden = true;
        cell.textfiled.placeholder = @"请选择钱包底层";
        cell.textfiled.userInteractionEnabled = false;
        if (self.bottomAddress) {
            cell.textfiled.text = self.bottomAddress;
        }
        
        if (self.model != nil) {
            cell.textfiled.text = self.model.wallettype;
            self.bottomAddress = self.model.wallettype;
        }
    }else if (indexPath.row == 3) {
        cell.titleLb.text = @"钱包地址";
        cell.arrowImage.hidden = true;
        cell.textfiled.placeholder = @"扫描或粘贴钱包地址";
        if (self.walletAddress) {
            cell.textfiled.text = self.walletAddress;
        }
        
        if (self.model != nil) {
            cell.textfiled.text = self.model.address;
            self.walletAddress = self.model.address;
        }
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        ETCoinListViewController *lVC = [ETCoinListViewController new];
        WEAK_SELF(self)
        [lVC setBlock:^(NSString * _Nonnull name) {
            
            STRONG_SELF(self);
            // 暂时写死
            self.bottomAddress = @"ETH";
            [self.detailTab reloadData];
        }];
        [self.navigationController pushViewController:lVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 49;
}







- (UIView *)footerView{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 44)];
    btn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    return backView;
    
}


- (void)clickAction {
   // NSUUID *uuid = [UIDevice currentDevice].identifierForVendor;
    //    NSLog(@"uuid 1 = %@",uuid.UUIDString);
    if ([Tools checkStringIsEmpty:self.nameString]) {
        [SVProgressHUD showInfoWithStatus:@"请输入名字"];
        return;
    }
    
    //    if ([Tools checkStringIsEmpty:self.nameString]) {
    //        [SVProgressHUD showInfoWithStatus:@"请输入名字"];
    //        return;
    //    }
    
    if ([Tools checkStringIsEmpty:self.bottomAddress]) {
        [SVProgressHUD showInfoWithStatus:@"请选择底层"];
        return;
    }
    
    if ([Tools checkStringIsEmpty:self.walletAddress]) {
        [SVProgressHUD showInfoWithStatus:@"请输入钱包地址"];
        return;
    }
    
    if (self.model == nil) {
        [self addContacts];
    }else{
        [self upContacts];
    }
    
}

- (void)addContacts{
    /*
        contacts 复制    [string]    是    设备号
        name    [string]    是    联系人姓名
        remarks    [string]    是    备注（可以为空）
        wallettype    [string]    是    不知道你们怎么选 后台只能添加ETH
        address    [string]    是    地址
        */
       NSString *uuidString = [UUID getUUID];
       NSMutableDictionary *dict = [NSMutableDictionary dictionary];
       [dict setValue:uuidString forKey:@"contacts"];
       [dict setValue:self.nameString forKey:@"name"];
       [dict setValue:self.backUpString forKey:@"remarks"];
       [dict setValue:self.bottomAddress forKey:@"wallettype"];
       [dict setValue:self.walletAddress forKey:@"address"];
       [HTTPTool requestDotNetWithURLString:@"et_addcontacts" parameters:dict type:kPOST success:^(id responseObject) {
           
           [SVProgressHUD showInfoWithStatus:@"创建成功"];
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [self.navigationController popViewControllerAnimated:YES];
           });
           
       } failure:^(NSError *error) {
           [SVProgressHUD showInfoWithStatus:@"创建失败"];
       }];
       
       
}

- (void)upContacts{
    /*
        contacts 复制    [string]    是    设备号
        name    [string]    是    联系人姓名
        remarks    [string]    是    备注（可以为空）
        wallettype    [string]    是    不知道你们怎么选 后台只能添加ETH
        address    [string]    是    地址
        */
       NSString *uuidString = [UUID getUUID];
       NSMutableDictionary *dict = [NSMutableDictionary dictionary];
       [dict setValue:uuidString forKey:@"contacts"];
       [dict setValue:self.nameString forKey:@"name"];
       [dict setValue:self.backUpString forKey:@"remarks"];
       [dict setValue:self.bottomAddress forKey:@"wallettype"];
       [dict setValue:self.walletAddress forKey:@"address"];
        [dict setValue:self.model.ID forKey:@"contactsid"];
       [HTTPTool requestDotNetWithURLString:@"et_upcontacts" parameters:dict type:kPOST success:^(id responseObject) {
           
           [SVProgressHUD showInfoWithStatus:@"修改成功"];
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [self.navigationController popViewControllerAnimated:YES];
           });
           
       } failure:^(NSError *error) {
           [SVProgressHUD showInfoWithStatus:@"修改失败"];
       }];
       
       
}

#pragma mark - ETAddContactsCellDelegate
- (void)ETAddContactsCellDelegateTextfiled:(UITextField *)textfiled rowPath:(NSIndexPath *)rowPath {
    
    switch (rowPath.row) {
        case 0: {
            self.nameString = textfiled.text;
        }
            break;
        case 1: {
            self.backUpString = textfiled.text;
        }
            break;
        case 2: {
            //            self.
        }
            break;
        case 3: {
            self.walletAddress = textfiled.text;
        }
            break;
        default:
            break;
    }
}

- (void)ETAddContactsCellDelegateScanClick {
    
    ETScanViewController *sVc = [ETScanViewController new];
    [sVc setScanBlock:^(NSString * _Nonnull qcodeString) {
        self.walletAddress = qcodeString;
        [self.detailTab reloadData];
    }];
    [self.navigationController pushViewController:sVc animated:YES];
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETAddContactsCell" bundle:nil] forCellReuseIdentifier:@"ETAddContactsCell"];
        _detailTab.tableFooterView = [self footerView];
    }
    return _detailTab;
}


@end
