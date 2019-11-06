//
//  ETChooseWalletcell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETChooseWalletcell.h"

@implementation ETChooseWalletcell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sy_zc_dk-1"]];
        [self.contentView addSubview:self.backImage];
        [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.height.mas_equalTo(70);
            
        }];
        
        self.iconImage = [[UIImageView alloc]init];
        [self.backImage addSubview:self.iconImage];
        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.backImage.mas_left).offset(15);
            make.width.height.mas_equalTo(44);
            make.centerY.equalTo(self.backImage.mas_centerY);
            
        }];
        
        self.titleLb = [[UILabel alloc]init];
        self.titleLb.font = [UIFont systemFontOfSize:14];
        self.titleLb.textColor = UIColorFromHEX(0x000000, 1);
        [self.contentView addSubview:self.titleLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.centerY.equalTo(self.iconImage.mas_centerY);
            
        }];
        
        
        
        self.subTtitlLb = [[UILabel alloc]init];
        self.subTtitlLb.font = [UIFont systemFontOfSize:10];
        self.subTtitlLb.text = @"点击切换";
        self.subTtitlLb.textColor = UIColorFromHEX(0x1D57FF, 1);
        [self.contentView addSubview:self.subTtitlLb];
        [self.subTtitlLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.backImage.mas_right).offset(-15);
            make.centerY.equalTo(self.iconImage.mas_centerY);
            
        }];
        
    }
    
    return self;
}


@end
