//
//  ETTransferGasView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransferGasView.h"
#import <ethers/ethers.h>

@interface ETTransferGasView()

@property (nonatomic,strong) UIView *gasView;

@property (nonatomic,strong) UILabel *countLb;

@end

@implementation ETTransferGasView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        self.gasView = [[UIView alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 340, SCREEN_WIDTH - 30, 310)];
        self.gasView.backgroundColor = UIColor.whiteColor;
        self.gasView.clipsToBounds = YES;
        self.gasView.layer.cornerRadius = 5;
        [self addSubview:self.gasView];
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.text = @"矿工费用设置";
        titleLb.font = [UIFont systemFontOfSize:16];
        titleLb.textColor = UIColorFromHEX(0x333333, 1);
        [self.gasView addSubview:titleLb];
        WEAK_SELF(self);
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.gasView.mas_left).offset(30);
            make.top.equalTo(self.gasView.mas_top).offset(20);
            
            
        }];
        
        
        
        UIButton *cancleBtn = [[UIButton alloc]init];
        [cancleBtn setImage:[UIImage imageNamed:@"qblb_guanbi"] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(canleAction) forControlEvents:UIControlEventTouchUpInside];
        [self.gasView addSubview:cancleBtn];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.centerY.equalTo(titleLb.mas_centerY);
            make.right.equalTo(self.gasView.mas_right).offset(-20);
            make.width.height.mas_equalTo(40);
            
        }];
        
        UISlider *slider = [[UISlider alloc]init];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        slider.minimumValue = 5;
        slider.maximumValue = 24;
        [self.gasView addSubview:slider];
        [slider mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.gasView.mas_left).offset(30);
            make.right.equalTo(self.gasView.mas_right).offset(-30);
            make.top.equalTo(titleLb.mas_bottom).offset(30);
            
        }];
        
        UILabel *leftLb = [[UILabel alloc]init];
        leftLb.text = @"慢";
        leftLb.font = [UIFont systemFontOfSize:16];
        leftLb.textColor = UIColorFromRGB(189,178,172, 1);
        [self.gasView addSubview:leftLb];
        [leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(slider.mas_left).offset(0);
            make.top.equalTo(slider.mas_bottom).offset(20);
            
            
        }];
        
        UILabel *rightLb = [[UILabel alloc]init];
        rightLb.text = @"快";
        rightLb.font = [UIFont systemFontOfSize:16];
        rightLb.textColor = UIColorFromRGB(189,178,172, 1);
        [self.gasView addSubview:rightLb];
        [rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(slider.mas_right).offset(0);
            make.top.equalTo(slider.mas_bottom).offset(20);
            
            
        }];
        
        UILabel *centerLb = [[UILabel alloc]init];
        centerLb.text = @"推荐";
        centerLb.font = [UIFont systemFontOfSize:16];
        centerLb.textColor = UIColorFromRGB(189,178,172, 1);
        [self.gasView addSubview:centerLb];
        [centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(slider.mas_centerX);
            make.top.equalTo(slider.mas_bottom).offset(20);
            
        }];
        
    
        self.countLb = [[UILabel alloc]init];
        self.countLb.text = [NSString stringWithFormat:@"0.00052%@",self.coinName];
        self.countLb.font = [UIFont systemFontOfSize:16];
        self.countLb.textColor = UIColorFromRGB(189,178,172, 1);
        [self.gasView addSubview:self.countLb];
        [self.countLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(slider.mas_left).offset(0);
            make.top.equalTo(slider.mas_bottom).offset(100);
            
            
        }];
        
        
        UISwitch *block = [[UISwitch alloc]init];
        [block addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self.gasView addSubview:block];
        [block mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(slider.mas_right);
            make.centerY.equalTo(self.countLb.mas_centerY);
            
        }];
        
        UILabel *tips = [[UILabel alloc]init];
        tips.text = @"高级模式";
        tips.font = [UIFont systemFontOfSize:16];
        tips.textColor = UIColorFromRGB(189,178,172, 1);
        [self.gasView addSubview:tips];
        [tips mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(block.mas_left).offset(-10);
            make.centerY.equalTo(block.mas_centerY);
            
        }];
        
        UIButton *comfirmBtn = [[UIButton alloc]init];
        comfirmBtn.clipsToBounds = YES;
        comfirmBtn.layer.cornerRadius = 5;
        comfirmBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
        [comfirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [comfirmBtn addTarget:self action:@selector(comfirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.gasView addSubview:comfirmBtn];
        [comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.countLb.mas_bottom).offset(30);
            make.left.equalTo(slider.mas_left);
            make.right.equalTo(slider.mas_right);
            make.height.mas_equalTo(44);
            
            
        }];
        
    }
    
    return self;
    
}

#pragma mark - canleAction
- (void)canleAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
  //  [[BigNumber bigNumberWithDecimalString:gasPrice] mul:[BigNumber bigNumberWithDecimalString:@"1000000000"]];
}

- (void)switchAction:(UISwitch *)block {
    
    block.on = false;
    [SVProgressHUD showInfoWithStatus:@"暂未开放"];
}


- (void)sliderAction:(UISlider *)slider {
    
    
    CGFloat value = slider.value;
    BigNumber *fl = [[BigNumber bigNumberWithDecimalString:[NSString stringWithFormat:@"%f",value]] mul:[BigNumber bigNumberWithDecimalString:@"1000000000"]];
    self.countLb.text = [NSString stringWithFormat:@"%@%@",fl.decimalString,self.coinName];
}

- (void)comfirmAction {
    
    [self canleAction];
    
}

- (void)setCoinName:(NSString *)coinName {
    
    _coinName = coinName;
    self.countLb.text = [NSString stringWithFormat:@"0.000052%@",coinName];
    
}
@end
