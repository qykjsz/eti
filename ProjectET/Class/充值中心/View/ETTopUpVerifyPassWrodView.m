//
//  ETTopUpVerifyPassWrodView.m
//  ProjectET
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTopUpVerifyPassWrodView.h"

@interface ETTopUpVerifyPassWrodView()

@property (nonatomic,strong) UIView *whiteView;

@property (nonatomic,strong) UITextField *textfiled;

@property (nonatomic, strong)UILabel *lab_miao;

@end

@implementation ETTopUpVerifyPassWrodView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
//        [self addGestureRecognizer:tap];
        
        self.whiteView = [[UIView alloc]init];
        self.whiteView.clipsToBounds = YES;
        self.whiteView.layer.cornerRadius = 5;
        self.whiteView.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-100);
            make.width.mas_equalTo(280);
            make.height.mas_equalTo(194);
            
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
        
        self.lab_miao = [[UILabel alloc]init];
        self.lab_miao.textColor = UIColorFromHEX(0x2357FF, 1);
        self.lab_miao.font = [UIFont systemFontOfSize:13];
        self.lab_miao.textAlignment = NSTextAlignmentRight;
        [self.whiteView addSubview: self.lab_miao];
        [self.lab_miao mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.whiteView.mas_right).offset(-15);
            make.top.equalTo(self.textfiled.mas_bottom).offset(12);
            make.width.mas_offset(40);
        }];
        
        self.lab_num = [[UILabel alloc]init];
        self.lab_num.textColor = UIColorFromHEX(0x333333, 1);
        self.lab_num.font = [UIFont systemFontOfSize:13];
        [self.whiteView addSubview: self.lab_num];
        [self.lab_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteView.mas_left).offset(15);
            make.top.equalTo(self.textfiled.mas_bottom).offset(12);
            make.right.equalTo(self.lab_miao.mas_left).offset(6);
        }];
        
        UIView *horView = [[UIView alloc]init];
        horView.backgroundColor = UIColorFromHEX(0xf2f2f2, 1);
        [self.whiteView addSubview:horView];
        [horView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.textfiled.mas_bottom).offset(42);
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
        
        [self getCheckCodeBtnStartTimer];
        
    }
    
    return self;
}

- (void)clickAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        [self dismissAction];
        
        
        if ([self.delegate respondsToSelector:@selector(ETTopUpVerifyPassWrodViewDelegateCancel)]) {
            [self.delegate ETTopUpVerifyPassWrodViewDelegateCancel];
        }
        
    }else {
        
        [self dismissAction];
        
        if ([self.delegate respondsToSelector:@selector(ETTopUpVerifyPassWrodViewDelegateComfirm)]) {
            [self.delegate ETTopUpVerifyPassWrodViewDelegateComfirm];
        }
        
        
        ETWalletModel *model = [ETWalletManger getCurrentWallet];
        if ([self.textfiled.text isEqualToString:model.password]) {
            if (self.Success) {
                self.Success();
            }
        }else {
            if (self.failure) {
                self.failure();
            }
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

#pragma mark. - 获取按钮倒计时
- (void)getCheckCodeBtnStartTimer{
    __block int timeout= 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_time,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_time, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_time);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissAction];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                self.lab_miao.text = [NSString stringWithFormat:@"%dS",timeout];
                [UIView commitAnimations];
            });
            timeout--;
        }
    });
    dispatch_resume(_time);
}

- (void)dismissAction {
    
    [self removeFromSuperview];
    
    //    [UIView animateWithDuration:0.3 animations:^{
    //        self.alpha = 0;
    //    } completion:^(BOOL finished) {
    //        [self removeFromSuperview];
    //    }];
}

@end
