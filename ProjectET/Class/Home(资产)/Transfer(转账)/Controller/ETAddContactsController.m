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
    if (indexPath.row == 0) {
        cell.titleLb.text = @"名字";
        cell.textfiled.placeholder = @"请输入名字";
        cell.arrowImage.hidden = true;
        cell.scanBtn.hidden = true;
    }else if (indexPath.row == 1) {
        cell.titleLb.text = @"备注";
        cell.textfiled.placeholder = @"选填";
        cell.arrowImage.hidden = true;
        cell.scanBtn.hidden = true;
    }else if (indexPath.row == 2) {
        cell.titleLb.text = @"钱包底层";
        cell.arrowImage.hidden = false;
        cell.scanBtn.hidden = true;
        cell.textfiled.placeholder = @"请选择钱包底层";
        cell.textfiled.userInteractionEnabled = false;
    }else if (indexPath.row == 3) {
        cell.titleLb.text = @"钱包地址";
        cell.arrowImage.hidden = true;
        cell.textfiled.placeholder = @"扫描或粘贴钱包地址";
        if (self.walletAddress) {
            cell.textfiled.text = self.walletAddress;
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
            self.bottomAddress = name;
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
