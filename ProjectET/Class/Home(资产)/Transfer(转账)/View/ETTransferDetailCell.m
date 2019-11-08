//
//  ETTransferDetailCell.m
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransferDetailCell.h"

@implementation ETTransferDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLb = [[UILabel alloc]init];
        self.titleLb.font = [UIFont systemFontOfSize:12];
        self.titleLb.textColor = UIColorFromHEX(0x999999, 1);
        [self.contentView addSubview:self.titleLb];
        WEAK_SELF(self);
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            
        }];
        
        self.detailLb = [[UILabel alloc]init];
        self.detailLb.font = [UIFont systemFontOfSize:14];
        self.detailLb.numberOfLines = 2;
        self.detailLb.textColor = UIColorFromHEX(0x010101, 1);
        [self.contentView addSubview:self.detailLb];
        [self.detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(84);
            make.centerY.equalTo(self.titleLb.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-45);
            
        }];
        
        self.subDetailLb = [[UILabel alloc]init];
        self.subDetailLb.font = [UIFont systemFontOfSize:11];
        self.subDetailLb.textColor = UIColorFromHEX(0x999999, 1);
        [self.contentView addSubview:self.subDetailLb];
        [self.subDetailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(84);
            make.top.equalTo(self.detailLb.mas_bottom).offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            
        }];
        
        self.clickBtn = [[UIButton alloc]init];
        [self.clickBtn setImage:[UIImage imageNamed:@"xq_fz"] forState:UIControlStateNormal];
        [self.clickBtn addTarget:self action:@selector(copyAcion) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.clickBtn];
        [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(40);
            
        }];
        
        self.lineImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
        [self.contentView addSubview:self.lineImage];
        [self.lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.height.mas_equalTo(1);
            
        }];
        
        
    }
    
    return self;
}

- (void)copyAcion {
    
    if ([self.delegate respondsToSelector:@selector(ETTransferDetailCellDelegateWithRowPath:)]) {
        [self.delegate ETTransferDetailCellDelegateWithRowPath:self.rowPath];
    }
}

@end
