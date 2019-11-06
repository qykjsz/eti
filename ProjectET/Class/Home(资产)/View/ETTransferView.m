//
//  ETTransferView.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransferView.h"
#import "UIButton+ImageTitleSpacing.h"



@implementation ETTransferView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        NSArray *titleArr = @[@"直接转账",@"联系人转账",@"扫码转账"];
        NSArray *iconArr = @[@"zz_zhuanzhang",@"zz_lianxiren",@"zz_ma"];
        NSInteger backViewW = (SCREEN_WIDTH - 60)/3;
        NSInteger backVIewH = 72;
        NSArray *arr = @[@"zz_lan",@"zz_zi",@"zz_lv"];
        for (int i = 0; i<3; i++) {
            
            UIButton *backView = [[UIButton alloc]initWithFrame:CGRectMake(15 + i*15 + i*backViewW, 25, backViewW, backVIewH)];
            backView.clipsToBounds = YES;
            backView.tag = i;
            backView.layer.cornerRadius = 5;
            [backView setTitle:titleArr[i] forState:UIControlStateNormal];
            [backView setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
            backView.titleLabel.font = [UIFont systemFontOfSize:14];
            [backView addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView setImage:[UIImage imageNamed:iconArr[i]] forState:UIControlStateNormal];
            [backView setBackgroundImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            [backView layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
            
            if (i == 0) {
                backView.backgroundColor = UIColorFromHEX(0x2687FF, 1);
            }else if (i == 1) {
                backView.backgroundColor = UIColorFromHEX(0xBC41FE, 1);
            }else {
                backView.backgroundColor = UIColorFromHEX(0x1FE69F, 1);
            }
            [self addSubview:backView];
            
        }
        
        UIView *verView = [[UIView alloc]init];
        verView.backgroundColor = UIColorFromHEX(0x2B80F4, 1);
        [self addSubview:verView];
        [verView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.mas_top).offset(127);
            make.left.equalTo(self.mas_left).offset(15);
            make.width.mas_equalTo(3);
            make.height.mas_equalTo(14);
            
        }];
        
        UILabel *tipsLb = [[UILabel alloc]init];
        tipsLb.font = [UIFont systemFontOfSize:16];
        tipsLb.textColor = UIColorFromHEX(0x000000, 1);
        tipsLb.text = @"转账记录";
        [self addSubview:tipsLb];
        [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(verView.mas_centerY);
            make.left.equalTo(verView.mas_right).offset(10);
        }];
        
    }
    return self;
}

- (void)clickAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ETTransferViewDelegateWithClikTag:)]) {
        [self.delegate ETTransferViewDelegateWithClikTag:sender.tag];
    }
    
}


@end
