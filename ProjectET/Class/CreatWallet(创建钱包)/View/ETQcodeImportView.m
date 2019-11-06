//
//  ETSyoImportView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETQcodeImportView.h"
#import "ETWalletImportCell.h"
#import "KMPQRCodeManager.h"

@interface ETQcodeImportView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) UITextView *syao;

@property (nonatomic,strong) UIImageView *qcodeImage;

@end

@implementation ETQcodeImportView

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
    
    return 2;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETWalletImportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETWalletImportCell"];
    if (indexPath.row == 0) {
        cell.titleLb.text = @"仅供直接扫描";
        cell.subTitleLb.text = @"二维码禁止保存、截图、及拍照。仅供用户在安全环境下直接扫 描来方便导入钱包";
    }else {
        cell.titleLb.text = @"在安全环境下使用";
        cell.subTitleLb.text = @"请在确保四周无人及无摄像头的情况下使用。二维码一旦 被他人 获取将造成不可换回的资产损失";
    }
    return cell;
}

- (UIView *)footerView {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
    backView.backgroundColor = UIColor.whiteColor;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    topView.backgroundColor = UIColorFromHEX(0xF2F2F2, 1);
    [backView addSubview:topView];
    
    UIView *garyView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, 30, 180, 180)];
    garyView.backgroundColor = UIColorFromHEX(0xE6E6E6, 1);
    [backView addSubview:garyView];
    
    UIImageView *eyeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dcsy_eye"]];
    [garyView addSubview:eyeImage];
    eyeImage.userInteractionEnabled = true;
    eyeImage.frame = CGRectMake(60, 50, 60, 42);
    
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"显示二维码" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(45, CGRectGetMaxY(eyeImage.frame) + 30, 90, 30);
    [garyView addSubview:btn];
    
    self.qcodeImage = [[UIImageView alloc]init];
    self.qcodeImage.frame = CGRectMake(0, 0, 180, 180);
    [garyView addSubview:self.qcodeImage];
    
    
    
    return backView;
    
}

- (void)showAction {
    
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    self.qcodeImage.image = [KMPQRCodeManager createQRCode:model.privateKey warterImage:nil];
    
}

- (void)copyAction {
    
    NSLog(@"copyAction");
    
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
