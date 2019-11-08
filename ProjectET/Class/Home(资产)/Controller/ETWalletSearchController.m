//
//  ETWalletSearchController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETWalletSearchController.h"
#import "ETWalletSearchCell.h"
@interface ETWalletSearchController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@end

@implementation ETWalletSearchController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self pageLayout];
    
    [self.view addSubview:self.detailTab];
    WEAK_SELF(self);
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        STRONG_SELF(self);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETWalletSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETWalletSearchCell"];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)pageLayout {
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchView];
    
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [cancelBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(searchView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
        
    }];
    
    UITextField *textfiled = [[UITextField alloc]init];
    textfiled.clipsToBounds = YES;
    textfiled.layer.cornerRadius = 12;
    textfiled.backgroundColor = UIColorFromHEX(0xf5f5f5, 1);
    textfiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索代币名称/合约/项目名称" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:12]}];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 30)];
    UIImageView *imag = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zc_sousuo"]];
    imag.frame = CGRectMake(10, 8, 14, 15);
    [backView addSubview:imag];
    textfiled.leftView = backView;
    textfiled.leftViewMode = UITextFieldViewModeAlways;
    [searchView addSubview:textfiled];
    [textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(searchView.mas_left).offset(15);
        make.centerY.equalTo(cancelBtn.mas_centerY);
        make.right.equalTo(searchView.mas_right).offset(-55);
        make.height.mas_equalTo(24);
        
    }];
    
    [textfiled addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromHEX(0xEBEBEB, 1);
    [searchView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(searchView);
        make.height.mas_equalTo(0.5);
        
    }];
}

#pragma mark - Atcion
- (void)cancleAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)textfieldDidChange:(UITextField *)text {
    
    NSLog(@"%@",text.text);
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETWalletSearchCell class] forCellReuseIdentifier:@"ETWalletSearchCell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
    }
    return _detailTab;
}




@end
