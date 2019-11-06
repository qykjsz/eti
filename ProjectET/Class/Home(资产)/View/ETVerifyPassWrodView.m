//
//  ETBackUpWalletView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETVerifyPassWrodView.h"

@interface ETVerifyPassWrodView()

@property (nonatomic,strong) UIView *whiteView;

@property (nonatomic,strong) UITextField *textfiled;


@end

@implementation ETVerifyPassWrodView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
        [self addGestureRecognizer:tap];
        
        self.whiteView = [[UIView alloc]init];
        self.whiteView.clipsToBounds = YES;
        self.whiteView.layer.cornerRadius = 5;
        self.whiteView.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-100);
            make.width.mas_equalTo(275);
            make.height.mas_equalTo(170);
            
        }];
        
        
        
        UILabel *tipsLb = [[UILabel alloc]init];
        tipsLb.text = @"验证密码";
        tipsLb.textAlignment = NSTextAlignmentCenter;
        tipsLb.font = [UIFont systemFontOfSize:14];
        tipsLb.textColor = UIColorFromHEX(0x333333, 1);
        [self.whiteView addSubview:tipsLb];
        [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self.whiteView);
            make.top.equalTo(self.whiteView.mas_top).offset(25);
            make.height.mas_equalTo(16);
            
        }];
        
        UIButton *eyeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 36)];
        [eyeBtn setImage:[UIImage imageNamed:@"tc_xianshi"] forState:UIControlStateNormal];
        [eyeBtn setImage:[UIImage imageNamed:@"zjc_nxs"] forState:UIControlStateSelected];
        [eyeBtn addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 36)];
        
        
        self.textfiled = [[UITextField alloc]init];
        self.textfiled.leftView = leftView;
        self.textfiled.leftViewMode = UITextFieldViewModeAlways;
        self.textfiled.placeholder = @"请输入密码";
        self.textfiled.clipsToBounds = YES;
        self.textfiled.layer.cornerRadius = 5;
        self.textfiled.rightView = eyeBtn;
        self.textfiled.font = [UIFont systemFontOfSize:14];
        self.textfiled.rightViewMode = UITextFieldViewModeAlways;
        self.textfiled.backgroundColor = UIColorFromHEX(0xf2f2f2, 1);
        [self.whiteView addSubview:self.textfiled];
        [self.textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.whiteView.mas_left).offset(15);
            make.right.equalTo(self.whiteView.mas_right).offset(-15);
            make.top.equalTo(tipsLb.mas_bottom).offset(30);
            make.height.mas_equalTo(36);
            
        }];
        
        UIView *horView = [[UIView alloc]init];
        horView.backgroundColor = UIColorFromHEX(0xf2f2f2, 1);
        [self.whiteView addSubview:horView];
        [horView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.textfiled.mas_bottom).offset(15);
            make.left.right.equalTo(self.whiteView);
            make.height.mas_equalTo(0.5);
            
        }];
        
        UIButton *deletBtn = [[UIButton alloc]init];
        [deletBtn setTitle:@"取消" forState:UIControlStateNormal];
        [deletBtn setTitleColor:UIColorFromHEX(0x999999, 1) forState:UIControlStateNormal];
        [deletBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        deletBtn.tag = 0;
        deletBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.whiteView addSubview:deletBtn];
        [deletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.bottom.equalTo(self.whiteView);
            make.width.mas_equalTo(140);
            make.top.equalTo(horView.mas_bottom);
            
        }];
        
        UIButton *backUpBtn = [[UIButton alloc]init];
        [backUpBtn setTitle:@"确定" forState:UIControlStateNormal];
        [backUpBtn setTitleColor:UIColorFromHEX(0x1D57FF, 1) forState:UIControlStateNormal];
        [backUpBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        backUpBtn.tag = 1;
        backUpBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.whiteView addSubview:backUpBtn];
        [backUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.bottom.equalTo(self.whiteView);
            make.width.mas_equalTo(140);
            make.top.equalTo(horView.mas_bottom);
            
        }];
        
        UIView *verView = [[UIView alloc]init];
        verView.backgroundColor = UIColorFromHEX(0xf2f2f2, 1);
        [self.whiteView addSubview:verView];
        [verView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(horView.mas_bottom);
            make.width.mas_equalTo(0.5);
            make.bottom.equalTo(self.whiteView.mas_bottom);
            make.centerX.equalTo(self.whiteView.mas_centerX);
            
        }];
        
        
    }
    
    return self;
}

- (void)clickAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        [self dismissAction];
        
      
        if ([self.delegate respondsToSelector:@selector(ETVerifyPassWrodViewDelegateCancel)]) {
            [self.delegate ETVerifyPassWrodViewDelegateCancel];
        }
        
    }else {
        
        [self dismissAction];
        
        if ([self.delegate respondsToSelector:@selector(ETVerifyPassWrodViewDelegateComfirm)]) {
            [self.delegate ETVerifyPassWrodViewDelegateComfirm];
        }
        
        
        ETWalletModel *model = [ETWalletManger getCurrentWallet];
        if ([self.textfiled.text isEqualToString:model.password]) {
            if (self.Success) {
                self.Success();
            }
        }else {
            [KMPProgressHUD showText:@"密码错误"];
        }
        
      
        
    }
}

- (void)eyeAction:(UIButton *)sender {
    
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        self.textfiled.secureTextEntry = YES;
    }else {
        self.textfiled.secureTextEntry = NO;
    }
    
}

- (void)dismissAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
