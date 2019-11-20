//
//  ETFoundCell.m
//  ProjectET
//
//  Created by hufeng on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundCell.h"

@implementation ETFoundCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        WEAK_SELF(self);
        self.iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fa_02"]];
        self.iconImage.clipsToBounds = YES;
        self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImage.layer.cornerRadius = 10;
        self.iconImage.layer.borderWidth = 1;
        self.iconImage.layer.borderColor = UIColorFromHEX(0xE0E0E0, 1).CGColor;
        [self.contentView addSubview:self.iconImage];
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.width.height.mas_equalTo(44);
            
        }];
        
        self.titleLb = [[UILabel alloc]init];
        self.titleLb.textColor = UIColorFromHEX(0x333333, 1);
        self.titleLb.font = [UIFont systemFontOfSize:11];
        self.titleLb.text = @"宝宝";
        self.titleLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.iconImage.mas_bottom).offset(10);
            
        }];
        
    }
    
    return self;
}

@end
