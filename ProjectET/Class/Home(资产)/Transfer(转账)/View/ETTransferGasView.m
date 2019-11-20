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

@property (nonatomic,assign) CGFloat gasmax;

@property (nonatomic,assign) CGFloat gasmin;

@property (nonatomic,assign) CGFloat gweimax;

@property (nonatomic,assign) CGFloat gweimin;

@property (nonatomic,assign) CGFloat tempfl;

@property (nonatomic,strong) UISlider *slider;

@property (nonatomic,assign) CGFloat seletGas;

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
        
        self.slider = [[UISlider alloc]init];
        [self.slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        self.slider.minimumValue = 5;
        self.slider.maximumValue = 24;
        [self.gasView addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
           
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
            
            make.left.equalTo(self.slider.mas_left).offset(0);
            make.top.equalTo(self.slider.mas_bottom).offset(20);
            
            
        }];
        
        UILabel *rightLb = [[UILabel alloc]init];
        rightLb.text = @"快";
        rightLb.font = [UIFont systemFontOfSize:16];
        rightLb.textColor = UIColorFromRGB(189,178,172, 1);
        [self.gasView addSubview:rightLb];
        [rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.slider.mas_right).offset(0);
            make.top.equalTo(self.slider.mas_bottom).offset(20);
            
            
        }];
        
        UILabel *centerLb = [[UILabel alloc]init];
        centerLb.text = @"推荐";
        centerLb.font = [UIFont systemFontOfSize:16];
        centerLb.textColor = UIColorFromRGB(189,178,172, 1);
        [self.gasView addSubview:centerLb];
        [centerLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.slider.mas_centerX);
            make.top.equalTo(self.slider.mas_bottom).offset(20);
            
        }];
        
    
        self.countLb = [[UILabel alloc]init];
        self.countLb.text = [NSString stringWithFormat:@"0.00052%@",self.coinName];
        self.countLb.font = [UIFont systemFontOfSize:16];
        self.countLb.textColor = UIColorFromRGB(189,178,172, 1);
        [self.gasView addSubview:self.countLb];
        [self.countLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.slider.mas_left).offset(0);
            make.top.equalTo(self.slider.mas_bottom).offset(100);
            
            
        }];
        
        
        UISwitch *block = [[UISwitch alloc]init];
        [block addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self.gasView addSubview:block];
        [block mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.slider.mas_right);
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
            make.left.equalTo(self.slider.mas_left);
            make.right.equalTo(self.slider.mas_right);
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
    
    
    self.seletGas = slider.value;
    self.tempfl = self.gasmin * self.seletGas / 1000000000;
    self.countLb.text = [NSString stringWithFormat:@"%f%@",self.tempfl,@"ETH"];

}

- (void)comfirmAction {
    
    [self canleAction];
    
    if (self.sliderBlcok) {
        self.sliderBlcok(self.seletGas, self.tempfl,[NSString stringWithFormat:@"%@",_data.gasmin]);
    }
    
}

- (void)setCoinName:(NSString *)coinName {
    
    _coinName = coinName;
    self.countLb.text = [NSString stringWithFormat:@"0.0000%@",coinName];
    
}

- (void)setData:(TransferGasData *)data {

    _data = data;
    self.seletGas = [data.gweimin floatValue];
    self.gasmax = [data.gasmax floatValue];
    self.gasmin = [data.gasmin floatValue];
    self.gweimin = [data.gweimin floatValue];
    self.gweimax = [data.gweimax floatValue];
    self.slider.maximumValue = [data.gweimax floatValue];
    self.slider.minimumValue = [data.gweimin floatValue];
    
    self.tempfl = self.gasmin * self.seletGas / 100000000;
    self.countLb.text = [NSString stringWithFormat:@"%f%@",self.tempfl,@"ETH"];
}

@end
