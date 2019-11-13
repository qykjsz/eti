//
//  HomeHeaderView.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "HomeHeaderView.h"
#import "UIButton+ImageTitleSpacing.h"



@interface HomeHeaderView()



@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       
        self.backgroundColor = UIColorFromHEX(0x0B50FB, 1);

        self.topLeftBtn = [[UIButton alloc]init];
//        [self.topLeftBtn setTitle:@"theeosportal >" forState:UIControlStateNormal];
        [self.topLeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
        [self.topLeftBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        self.topLeftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        self.topLeftBtn.tag = 0;
        [self.topLeftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.topLeftBtn];
        
        UIButton *topminBtn = [[UIButton alloc]init];
        [topminBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        topminBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [topminBtn setImage:[UIImage imageNamed:@"sy_tianjia"] forState:UIControlStateNormal];
        topminBtn.tag = 1;
        [topminBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:topminBtn];
        
        UIButton *toprightBtn = [[UIButton alloc]init];
        [toprightBtn setImage:[UIImage imageNamed:@"sy_sao"] forState:UIControlStateNormal];
        [toprightBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        toprightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        toprightBtn.tag = 2;
        [toprightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:toprightBtn];
        
        
        UIButton *leftBtn = [[UIButton alloc]init];
        [leftBtn setTitle:@"转账" forState:UIControlStateNormal];
        [leftBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [leftBtn setImage:[UIImage imageNamed:@"sy_zhuan"] forState:UIControlStateNormal];
        leftBtn.tag = 3;
       
        [leftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
        UIButton *minBtn = [[UIButton alloc]init];
        [minBtn setTitle:@"收款" forState:UIControlStateNormal];
        [minBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        minBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [minBtn setImage:[UIImage imageNamed:@"sy_shou"] forState:UIControlStateNormal];
        minBtn.tag = 4;
       
        [minBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:minBtn];
        
        UIButton *rightBtn = [[UIButton alloc]init];
        [rightBtn setTitle:@"闪兑" forState:UIControlStateNormal];
        [rightBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [rightBtn setImage:[UIImage imageNamed:@"sy_shan"] forState:UIControlStateNormal];
        rightBtn.tag = 5;
       
        [rightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        
        [self.topLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(0);
            make.top.equalTo(self.mas_top).offset(kStatusBarHeight);
            make.width.equalTo(@150);
            make.height.equalTo(@30);
            
        }];
        
        [toprightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self.topLeftBtn.mas_centerY);
            make.width.height.mas_equalTo(23);
            
        }];
        
        [topminBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self.topLeftBtn.mas_centerY);
            make.right.equalTo(toprightBtn.mas_left).offset(-24);
            make.width.height.mas_equalTo(23);
            
        }];
        
        NSInteger btnW = SCREEN_WIDTH/3;
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(100);
            make.top.equalTo(self.topLeftBtn.mas_bottom);
            make.left.equalTo(self.mas_left);
            
        }];
        
        [minBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(100);
            make.top.equalTo(self.topLeftBtn.mas_bottom);
            make.left.equalTo(leftBtn.mas_right);
            
        }];
        
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(100);
            make.top.equalTo(self.topLeftBtn.mas_bottom);
            make.left.equalTo(minBtn.mas_right);
            
        }];
        
         [minBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
         [rightBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
         [leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        
    }
    return self;
}

- (void)clickAction:(UIButton *)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(HomeHeaderViewDelegateWithClickTag:)]) {
        [self.delegate HomeHeaderViewDelegateWithClickTag:sender.tag];
    }
}

@end
