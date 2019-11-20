//
//  ETBackUpWalletView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETBackUpWalletView.h"

@interface ETBackUpWalletView()

@property (nonatomic,strong) UIView *whiteView;

@end

@implementation ETBackUpWalletView

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
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(275);
            make.height.mas_equalTo(180);
            
        }];
        
        UIImageView *iconImage = [[UIImageView alloc]init];
        iconImage.image = [UIImage imageNamed:@"sy_jingshi"];
        [self.whiteView addSubview:iconImage];
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.whiteView.mas_centerX);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(44);
            make.top.equalTo(self.whiteView.mas_top).offset(30);
            
        }];
        
        UILabel *tipsLb = [[UILabel alloc]init];
        tipsLb.text = @"为了您的钱包安全，请备份钱包";
        tipsLb.textAlignment = NSTextAlignmentCenter;
        tipsLb.font = [UIFont systemFontOfSize:14];
        tipsLb.textColor = UIColorFromHEX(0x333333, 1);
        [self.whiteView addSubview:tipsLb];
        [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.equalTo(self.whiteView);
            make.top.equalTo(iconImage.mas_bottom).offset(15);
            make.height.mas_equalTo(16);
            
        }];
        
        UIView *horView = [[UIView alloc]init];
        horView.backgroundColor = UIColorFromHEX(0xf2f2f2, 1);
        [self.whiteView addSubview:horView];
        [horView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(tipsLb.mas_bottom).offset(25);
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
        [backUpBtn setTitle:@"立即备份" forState:UIControlStateNormal];
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
        
//        if ([self.delegate respondsToSelector:@selector(ETBackUpWalletViewDelegateDeletAction:)]) {
//            [self.delegate ETBackUpWalletViewDelegateDeletAction:self.model];
//        }
    }else {
        
        [self dismissAction];
        
        if ([self.delegate respondsToSelector:@selector(ETBackUpWalletViewDelegateBackUpAction:)]) {
            [self.delegate ETBackUpWalletViewDelegateBackUpAction:self.model];
        }
        
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
