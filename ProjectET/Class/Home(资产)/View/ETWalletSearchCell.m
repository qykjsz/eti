//
//  ETWalletSearchCell.m
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETWalletSearchCell.h"

@implementation ETWalletSearchCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.iconImage];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.subTitleLb];
        [self.contentView addSubview:self.clickBtn];
        
        WEAK_SELF(self);
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(44);
        }];
        
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(20);
            
        }];
        
        [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.top.equalTo(self.titleLb.mas_bottom).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-56);
            
        }];
        
        [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(54);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(44);
            make.right.equalTo(self.contentView.mas_right);
            
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = UIColorFromHEX(0xEBEBEB, 1);
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(74);
            make.bottom.right.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
            
        }];
    }
    
    return self;
    
}

- (void)setModel:(ETPlatformGlodData *)model {
    
    _model = model;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.titleLb.text = model.name;
    self.subTitleLb.text = model.hyaddress;
    // 1是有  2是没有
    if ([model.have isEqualToString:@"1"]) {
        self.clickBtn.selected = YES;
    }else {
        self.clickBtn.selected = NO;
    }
    
    
}

#pragma mark - lazy load
- (UIImageView *)iconImage {
    
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qbgl_tron_xz"]];
    }
    return _iconImage;
}

- (UILabel *)titleLb {
    
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.text = @"ETH";
        _titleLb.textColor = UIColorFromHEX(0x333333, 1);
        _titleLb.font = [UIFont systemFontOfSize:20];
    }
    return _titleLb;
}

- (UILabel *)subTitleLb {
    
    if (!_subTitleLb) {
        _subTitleLb = [[UILabel alloc]init];
        _subTitleLb.text = @"f47rf83h34fh38f9h3fh93f9h3fh93fh94fgh49ifgh49fh";
        _subTitleLb.textColor = UIColorFromHEX(0x999999, 1);
        _subTitleLb.font = [UIFont systemFontOfSize:10];
    }
    return _subTitleLb;
}


- (UIButton *)clickBtn {
    
    if (!_clickBtn) {
        _clickBtn = [[UIButton alloc]init];
        [_clickBtn setImage:[UIImage imageNamed:@"sousuo_jia"] forState:UIControlStateNormal];
        [_clickBtn setImage:[UIImage imageNamed:@"ss_jian"] forState:UIControlStateSelected];
    }
    return _clickBtn;
}

@end
