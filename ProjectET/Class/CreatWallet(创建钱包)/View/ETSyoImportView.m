//
//  ETSyoImportView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETSyoImportView.h"
#import "ETWalletImportCell.h"

@interface ETSyoImportView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;



@end

@implementation ETSyoImportView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.detailTab];
        self.detailTab.tableFooterView = [self footerView];
        [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(self);
            
        }];
    }
    
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETWalletImportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETWalletImportCell"];
    if (indexPath.row == 0) {
        cell.titleLb.text = @"离线保存";
        cell.subTitleLb.text = @"切勿保存至邮箱、记事本、网盘、聊天工具等，非常危险";
    }else if (indexPath.row == 1) {
        cell.titleLb.text = @"请勿使用网络传输";
        cell.subTitleLb.text = @"请勿通过网络工具传输，一旦被黑客获取将造成不可挽回的资产 损失。建议离线设备通过扫二维码方式传输";
    }else {
        cell.titleLb.text = @"密码管理工具保存";
        cell.subTitleLb.text = @"建议使用密码管理工具管理";
    }
    return cell;
}

- (UIView *)footerView {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
    backView.backgroundColor = UIColor.whiteColor;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    topView.backgroundColor = UIColorFromHEX(0x999999, 1);
    [backView addSubview:topView];
    
    self.syao = [[UITextView alloc]initWithFrame:CGRectMake(15, 35, SCREEN_WIDTH - 30, 80)];
    self.syao.backgroundColor = UIColorFromHEX(0xF0F0F0, 1);
    self.syao.textColor = UIColorFromHEX(0x333333, 1);
    self.syao.clipsToBounds = YES;
    self.syao.layer.cornerRadius = 5;
    self.syao.editable = false;
    self.syao.text = @"";
    [backView addSubview:self.self.syao];
    
    UIButton *copyBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.syao.frame) + 100, SCREEN_WIDTH - 30, 44)];
    [copyBtn setTitle:@"复制私钥" forState:UIControlStateNormal];
    copyBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    [copyBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [copyBtn addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
    copyBtn.clipsToBounds = YES;
    copyBtn.layer.cornerRadius = 5;
    [backView addSubview:copyBtn];
    
    return backView;
    
}

- (void)copyAction {
    
//    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [Tools copyClickWithText:self.syao.text];
    
}

#pragma mark - layz load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETWalletImportCell" bundle:nil] forCellReuseIdentifier:@"ETWalletImportCell"];
    }
    return _detailTab;
}

@end
