//
//  ETChangePassWordController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETChangePassWordController.h"
#import "ETAddContactsCell.h"

#import "ETBackUpWalletView.h"
#import "ETVerifyPassWrodView.h"
@interface ETChangePassWordController ()<UITableViewDelegate,UITableViewDataSource,ETAddContactsCellDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSString *oldPassWord;

@property (nonatomic,strong) NSString *changePassWordString;

@property (nonatomic,strong) NSString *comfirmWord;

@end

@implementation ETChangePassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top);
        make.left.right.bottom.equalTo(self.view);
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETAddContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETAddContactsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rowPath = indexPath;
    cell.delegate = self;
    [cell.textfiled setSecureTextEntry:true];
    if (indexPath.row == 0) {
        cell.titleLb.text = @"当前密码";
        cell.textfiled.placeholder = @"请输入当前密码";
        cell.arrowImage.hidden = true;
        cell.scanBtn.hidden = true;
    }else if (indexPath.row == 1) {
        cell.titleLb.text = @"新密码";
        cell.textfiled.placeholder = @"请输入新密码";
        cell.arrowImage.hidden = true;
        cell.scanBtn.hidden = true;
    }else if (indexPath.row == 2) {
        cell.titleLb.text = @"确认密码";
        cell.arrowImage.hidden = false;
        cell.scanBtn.hidden = true;
        cell.textfiled.placeholder = @"请再次输入密码";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 49;
}

- (UIView *)footerView{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 44)];
    btn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    return backView;
    
}


- (void)clickAction {
    
    ETWalletModel *model = [ETWalletManger getModelIndex:self.selectTag];
    
    if ([self.oldPassWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [KMPProgressHUD showText:@"请输入当前密码"];
        return;
    }
    
    if ([self.changePassWordString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [KMPProgressHUD showText:@"请输入新密码"];
        return;
    }
    
    if ([self.comfirmWord stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [KMPProgressHUD showText:@"请输入确认密码"];
        return;
    }
    
    if (![self.oldPassWord isEqualToString:model.password]) {
        [KMPProgressHUD showText:@"当前密码输入错误"];
        return;
    }
    
    if (![self.changePassWordString isEqualToString:self.comfirmWord]) {
        [KMPProgressHUD showText:@"两次密码输入不一致"];
        return;
    }
    
    model.password = self.changePassWordString;
    [ETWalletManger updateWallet:model];
    
    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    
}

#pragma mark - ETAddContactsCellDelegate
- (void)ETAddContactsCellDelegateTextfiled:(UITextField *)textfiled rowPath:(NSIndexPath *)rowPath {
    
    if (rowPath.row == 0) {
        self.oldPassWord = textfiled.text;
    }else if (rowPath.row == 1) {
        self.changePassWordString = textfiled.text;
    }else {
        self.comfirmWord = textfiled.text;
    }
    
}
#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETAddContactsCell" bundle:nil] forCellReuseIdentifier:@"ETAddContactsCell"];
        _detailTab.tableFooterView = [self footerView];
    }
    return _detailTab;
}


@end
