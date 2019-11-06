//
//  ETSecertCreatView.m
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETSecertCreatView.h"
#import "UIButton+ImageTitleSpacing.h"

@interface ETSecertCreatView()

@property (nonatomic,strong) UILabel *gDetailLb;

@property (nonatomic,strong) UILabel *sDetailLb;

@end

@implementation ETSecertCreatView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
        [self addGestureRecognizer:tap];
        
        UIView *whiteBackView = [[UIView alloc]init];
        whiteBackView.backgroundColor = UIColor.whiteColor;
        whiteBackView.clipsToBounds = YES;
        whiteBackView.layer.cornerRadius = 5;
        [self addSubview:whiteBackView];
        [whiteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.mas_left).offset(50);
            make.right.equalTo(self.mas_right).offset(-50);
            make.height.mas_equalTo(300);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            
        }];
        
        UIButton *topTips = [[UIButton alloc]init];
        [topTips setTitle:@"密钥生成器" forState:UIControlStateNormal];
        [topTips setTitleColor:UIColorFromHEX(0x000000, 1) forState:UIControlStateNormal];
        topTips.titleLabel.font = [UIFont systemFontOfSize:14];
        [topTips setImage:[UIImage imageNamed:@"my_yao"] forState:UIControlStateNormal];
        [whiteBackView addSubview:topTips];
        [topTips mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(whiteBackView.mas_centerX);
            make.top.equalTo(whiteBackView.mas_top).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        
        [topTips layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        
        UIButton *reload = [[UIButton alloc]init];
        reload.titleLabel.font = [UIFont systemFontOfSize:14];
        [reload setImage:[UIImage imageNamed:@"my_shuaxin"] forState:UIControlStateNormal];
        [reload addTarget:self action:@selector(reloadAction) forControlEvents:UIControlEventTouchUpInside];
        [whiteBackView addSubview:reload];
        [reload mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(topTips.mas_centerY);
            make.right.equalTo(whiteBackView.mas_right).offset(-10);
            make.width.height.mas_equalTo(30);
            
        }];
        
        UILabel *gLb = [[UILabel alloc]init];
        gLb.font = [UIFont systemFontOfSize:14];
        gLb.text = @"·公钥";
        gLb.textColor = UIColorFromHEX(0x333333, 1);
        [whiteBackView addSubview:gLb];
        [gLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(whiteBackView.mas_left).offset(15);
            make.top.equalTo(topTips.mas_bottom).offset(20);
            
        }];
        
        self.gDetailLb = [[UILabel alloc]init];
        self.gDetailLb.numberOfLines = 2;
        self.gDetailLb.font = [UIFont systemFontOfSize:11];
        self.gDetailLb.text = @"cbcksfh9w09dwjcnwdx9j2m2xjmexniw";
        self.gDetailLb.textColor = UIColorFromHEX(0x999999, 1);
        [whiteBackView addSubview:self.gDetailLb];
        [self.gDetailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(whiteBackView.mas_left).offset(15);
            make.top.equalTo(gLb.mas_bottom).offset(15);
            make.right.equalTo(whiteBackView.mas_right).offset(-50);
        }];
        
        UIButton *copyBtn = [[UIButton alloc]init];
        copyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [copyBtn setImage:[UIImage imageNamed:@"zc_fuzhi"] forState:UIControlStateNormal];
        [copyBtn addTarget:self action:@selector(gYaoCopyAction) forControlEvents:UIControlEventTouchUpInside];
        [whiteBackView addSubview:copyBtn];
        [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.gDetailLb.mas_centerY);
            make.right.equalTo(whiteBackView.mas_right).offset(-10);
            make.width.height.mas_equalTo(30);
            
        }];
        
        UILabel *sLb = [[UILabel alloc]init];
        sLb.font = [UIFont systemFontOfSize:14];
        sLb.text = @"·私钥";
        sLb.textColor = UIColorFromHEX(0x333333, 1);
        [whiteBackView addSubview:sLb];
        [sLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(whiteBackView.mas_left).offset(15);
            make.top.equalTo(self.gDetailLb.mas_bottom).offset(30);
            
        }];
        
        self.sDetailLb = [[UILabel alloc]init];
        self.sDetailLb.numberOfLines = 2;
        self.sDetailLb.font = [UIFont systemFontOfSize:11];
        self.sDetailLb.text = @"cbcksfh9w09dwjcnwdx9j2m2xjmexniw";
        self.sDetailLb.textColor = UIColorFromHEX(0x999999, 1);
        [whiteBackView addSubview:self.sDetailLb];
        [self.sDetailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(whiteBackView.mas_left).offset(15);
            make.top.equalTo(sLb.mas_bottom).offset(15);
            make.right.equalTo(whiteBackView.mas_right).offset(-50);
        }];
        
        UIButton *sBtn = [[UIButton alloc]init];
        sBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [sBtn setImage:[UIImage imageNamed:@"zc_fuzhi"] forState:UIControlStateNormal];
        [sBtn addTarget:self action:@selector(sYaoCopyAction) forControlEvents:UIControlEventTouchUpInside];
        [whiteBackView addSubview:sBtn];
        [sBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.sDetailLb.mas_centerY);
            make.right.equalTo(whiteBackView.mas_right).offset(-10);
            make.width.height.mas_equalTo(30);
            
        }];
        
        UIButton *clickBtn = [[UIButton alloc]init];
        [clickBtn setTitle:@"去使用" forState:UIControlStateNormal];
        clickBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
        clickBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [clickBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        clickBtn.clipsToBounds = YES;
        clickBtn.layer.cornerRadius = 5;
        [whiteBackView addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.sDetailLb.mas_bottom).offset(35);
            make.left.equalTo(whiteBackView.mas_left).offset(35);
            make.right.equalTo(whiteBackView.mas_right).offset(-35);
            make.height.mas_equalTo(35);
            
        }];
        
        UILabel *bottomLb = [[UILabel alloc]init];
        bottomLb.numberOfLines = 1;
        bottomLb.font = [UIFont systemFontOfSize:11];
        bottomLb.text = @"温馨提示：使用密钥前请备份私钥";
        bottomLb.textColor = UIColorFromHEX(0x1D57FF, 1);
        [whiteBackView addSubview:bottomLb];
        [bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(whiteBackView.mas_centerX);
            make.top.equalTo(clickBtn.mas_bottom).offset(10);
            
        }];
        
        
    }
    
    return self;
}

- (void)gYaoCopyAction {
    

    [Tools copyClickWithText:self.gDetailLb.text];
    
}

- (void)sYaoCopyAction {
    
    [Tools copyClickWithText:self.sDetailLb.text];
    
}

- (void)reloadAction {
    
    
}

- (void)clickAction {
    
    if ([self.delegate respondsToSelector:@selector(ETSecertCreatViewDelegateGyaoClick:andSyao:)]) {
        [self.delegate ETSecertCreatViewDelegateGyaoClick:self.gDetailLb.text andSyao:self.sDetailLb.text];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)dismissAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
