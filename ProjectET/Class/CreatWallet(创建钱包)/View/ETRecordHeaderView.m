//
//  ETRecordHeaderView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/1.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETRecordHeaderView.h"

@implementation ETRecordHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qb_bg"]];
        [self addSubview:backImage];
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(20);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.height.mas_equalTo(160);
            
        }];
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.text = @"资产正在保护中";
        titleLb.font = [UIFont systemFontOfSize:12];
        titleLb.textColor = UIColorFromHEX(0x1A59FB, 1);
        [backImage addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(backImage.mas_right).offset(-10);
            make.top.equalTo(backImage.mas_top).offset(-5);
            make.height.mas_equalTo(35);
            
        }];
        
        UIImageView *titileImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sy_anquan"]];
        [backImage addSubview:titileImage];
        [titileImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(titleLb.mas_centerY);
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(15);
            make.right.equalTo(titleLb.mas_left).offset(-10);
            
        }];
        
        [self addSubview:self.tipsLb];
        [self.tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(backImage.mas_top).offset(40);
            make.left.equalTo(backImage.mas_left).offset(15);
            
        }];
        
        [self addSubview:self.eyeBtn];
        [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.tipsLb.mas_centerY);
            make.left.equalTo(self.tipsLb.mas_right).offset(10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(13);
            
        }];
        
        [self addSubview:self.moneyLb];
        [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.tipsLb.mas_bottom).offset(15);
            make.left.equalTo(backImage.mas_left).offset(15);
            make.right.equalTo(backImage.mas_right).offset(-150);
            
        }];
        
        [self addSubview:self.subMoneyLb];
        [self.subMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(120);
            make.right.equalTo(backImage.mas_right).offset(-15);
            make.bottom.equalTo(self.moneyLb.mas_bottom).offset(-10);
            
        }];
        
        
//        [self.tipsLb mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.subMoneyLb.mas_left).offset(10);
//        }];
        
        [self addSubview:self.todayLb];
        [self.todayLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.moneyLb.mas_bottom).offset(10);
            make.left.equalTo(backImage.mas_left).offset(15);
            
        }];
        
    }
    return self;
}

#pragma mark - lazy load

- (UILabel *)tipsLb {
    
    if (!_tipsLb) {
        _tipsLb = [[UILabel alloc]init];
        _tipsLb.font = [UIFont systemFontOfSize:13];
        _tipsLb.textColor = UIColorFromHEX(0xF5F5F5, 1);
        _tipsLb.text = @"我的总资产（$)";
    }
    return _tipsLb;
}

- (UILabel *)moneyLb {
    
    if (!_moneyLb) {
        _moneyLb = [[UILabel alloc]init];
        _moneyLb.font = [UIFont systemFontOfSize:33];
        _moneyLb.textColor = UIColorFromHEX(0xF5F5F5, 1);
//        _moneyLb.text = @"999.99";
    }
    return _moneyLb;
}

- (UILabel *)subMoneyLb {
    
    if (!_subMoneyLb) {
        _subMoneyLb = [[UILabel alloc]init];
        _subMoneyLb.font = [UIFont systemFontOfSize:12];
        _subMoneyLb.textColor = UIColorFromHEX(0xffffff, 1);
        _subMoneyLb.textAlignment = NSTextAlignmentRight;
//        _subMoneyLb.text = @"≈$ 638383.7889";
    }
    return _subMoneyLb;
}

- (UIButton *)eyeBtn {
    
    if (!_eyeBtn) {
        _eyeBtn = [[UIButton alloc]init];
        [_eyeBtn setImage:[UIImage imageNamed:@"sy_yincang"] forState:UIControlStateNormal];
        [_eyeBtn setImage:[UIImage imageNamed:@"sy_xianshi"] forState:UIControlStateSelected];
        _eyeBtn.selected = YES;
        [_eyeBtn addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyeBtn;
}

- (void)eyeAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RECODEREYEACTION" object:@{@"isOpen":@(sender.selected)}];
}

- (UILabel *)todayLb {
    
    if (!_todayLb) {
        _todayLb = [[UILabel alloc]init];
        _todayLb.font = [UIFont systemFontOfSize:13];
        _todayLb.textColor = UIColorFromHEX(0xF5F5F5, 1);
//        _todayLb.text = @"今日 +120.36";
    }
    return _todayLb;
}
    
@end
