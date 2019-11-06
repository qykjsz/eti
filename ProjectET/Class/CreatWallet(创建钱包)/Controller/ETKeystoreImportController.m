//
//  ETKeystoreImportController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETKeystoreImportController.h"
#import "ETKeystoreQcodeView.h"
#import "ETKeystoreImporView.h"
@interface ETKeystoreImportController ()

@property (nonatomic,strong) UIButton *leftBtn;

@property (nonatomic,strong) UIButton *rightBtn;

@property (nonatomic,strong) UIScrollView *backScro;

@property (nonatomic,strong) ETKeystoreImporView *leftView;

@property (nonatomic,strong) ETKeystoreQcodeView *rightView;


@end

@implementation ETKeystoreImportController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"导出Keystore";
    
    
    
    [self.view addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(45);
        
    }];
    
    [self.view addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.leftBtn.mas_right);
        make.top.equalTo(self.view);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(45);
        
    }];
    
    self.backScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backScro.scrollEnabled = NO;
    self.backScro.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT);
    [self.view addSubview:self.backScro];
    
    
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    
    self.leftView = [[ETKeystoreImporView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.leftView.syao.text = model.keyStore;
    [self.backScro addSubview:self.leftView];
    
    self.rightView = [[ETKeystoreQcodeView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.backScro addSubview:self.rightView];
}

#pragma mark - lazy load
- (UIButton *)leftBtn {
    
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]init];
        _leftBtn.tag = 0;
        [_leftBtn setTitleColor:UIColorFromHEX(0x99AFD9, 1) forState:UIControlStateNormal];
        [_leftBtn setTitleColor:UIColorFromHEX(0x000000, 1) forState:UIControlStateSelected];
        [_leftBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitle:@"Keystore" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _leftBtn.selected = YES;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]init];
        _rightBtn.tag = 1;
        [_rightBtn setTitleColor:UIColorFromHEX(0x99AFD9, 1) forState:UIControlStateNormal];
        [_rightBtn setTitleColor:UIColorFromHEX(0x000000, 1) forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitle:@"二维码" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rightBtn;
}

- (void)changeAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self.backScro setContentOffset:CGPointMake(0, 0) animated:YES];
        
        
    }else {
        
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [self.backScro setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
        
    }
    
}


@end
