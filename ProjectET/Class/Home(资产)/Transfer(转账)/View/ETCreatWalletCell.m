//
//  ETCreatWalletCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETCreatWalletCell.h"

@implementation ETCreatWalletCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        WEAK_SELF(self);
        self.backImage = [[UIImageView alloc]init];
        self.backImage.contentMode = UIViewContentModeScaleToFill;
        self.backImage.clipsToBounds = YES;
        self.backImage.layer.cornerRadius = 7;
        [self.contentView addSubview:self.backImage];
        [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.height.mas_equalTo(70);
            
        }];
        
//        self.backGrayView = [[UIView alloc]init];
//        self.backGrayView.clipsToBounds = YES;
//        self.backGrayView.layer.cornerRadius = 7;
//        self.backGrayView.backgroundColor = UIColorFromHEX(0xf5f5f5, 1);
//        [self.backImage addSubview:self.backGrayView];
//        [self.backGrayView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            STRONG_SELF(self);
//            make.edges.equalTo(self.backImage);
//
//        }];
        
        self.iconImage = [[UIImageView alloc]init];
        [self.backImage addSubview:self.iconImage];
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.backImage.mas_left).offset(15);
            make.width.height.mas_equalTo(44);
            make.centerY.equalTo(self.backImage.mas_centerY);
            
        }];
        
        self.titleLb = [[UILabel alloc]init];
        self.titleLb.font = [UIFont systemFontOfSize:15];
        self.titleLb.textColor = UIColorFromHEX(0x000000, 1);
        [self.contentView addSubview:self.titleLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.top.equalTo(self.backImage.mas_top).offset(20);
            
        }];
        
        self.subTtitlLb = [[UILabel alloc]init];
        self.subTtitlLb.font = [UIFont systemFontOfSize:12];
        self.subTtitlLb.textColor = UIColorFromHEX(0x999999, 1);
        [self.contentView addSubview:self.subTtitlLb];
        [self.subTtitlLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.bottom.equalTo(self.iconImage.mas_bottom);
            
        }];
        
        self.arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wd_gd_icon"]];
        [self.contentView addSubview:self.arrowImage];
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.right.equalTo(self.backImage.mas_right).offset(-15);
            make.centerY.equalTo(self.backImage.mas_centerY);
            make.width.mas_equalTo(7);
            make.height.mas_equalTo(12);
            
        }];
        
    }
    
    return self;
}

@end
