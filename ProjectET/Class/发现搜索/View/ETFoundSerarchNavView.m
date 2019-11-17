//
//  ETFoundSerarchNavView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundSerarchNavView.h"

@interface ETFoundSerarchNavView()<UITextFieldDelegate>

@end

@implementation ETFoundSerarchNavView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kStatusAndNavHeight)];
        backView.backgroundColor = UIColor.whiteColor;
        self.textfiled = [[UITextField alloc]initWithFrame:CGRectMake(15, iPhoneBang?kStatusBarHeight:(kStatusBarHeight + 5), SCREEN_WIDTH - 70,30)];
        self.textfiled.clipsToBounds = YES;
        self.textfiled.layer.cornerRadius = 15;
        self.textfiled.placeholder = @"搜索";
        self.textfiled.font = [UIFont systemFontOfSize:14];
        self.textfiled.textColor = UIColorFromHEX(0x000000, 1);
        self.textfiled.backgroundColor = UIColorFromHEX(0xF0F0F0, 1);
        [self.textfiled addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.textfiled.delegate = self;
        [self addSubview:backView];
        
        
        UIView *textfiledBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 36, 30)];
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 16, 18)];
        icon.image = [UIImage imageNamed:@"fx_spusuo"];
        [textfiledBackView addSubview:icon];
        self.textfiled.leftView = textfiledBackView;
        self.textfiled.leftViewMode = UITextFieldViewModeAlways;
        [backView addSubview:self.textfiled];
        UIButton *cancleBtn = [[UIButton alloc]init];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:UIColorFromHEX(0x000000, 1) forState:UIControlStateNormal];
        cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:cancleBtn];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(backView.mas_right).offset(-10);
            make.centerY.equalTo(self.textfiled.mas_centerY);
            make.width.height.mas_equalTo(40);
            
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = UIColorFromHEX(0xF0F0F0, 1);
        [backView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.equalTo(backView);
            make.height.mas_equalTo(0.5);
            
        }];
    }
    
    return self;
}

- (void)cancleAction {
    
    if ([self.delegate respondsToSelector:@selector(ETFoundSerarchNavViewCancle)]) {
        [self.delegate ETFoundSerarchNavViewCancle];
    }
    
}

- (void)textfieldDidChange:(UITextField *)textfiled{
    
    if ([self.delegate respondsToSelector:@selector(ETFoundSerarchNavViewTextfiled:)]) {
        [self.delegate ETFoundSerarchNavViewTextfiled: textfiled];
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(ETFoundSerarchNavViewReturn:)]) {
        [self.delegate ETFoundSerarchNavViewReturn:textField];
    }
    
    return YES;
}


@end
