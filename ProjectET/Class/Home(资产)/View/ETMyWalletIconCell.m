//
//  ETMyWalletIconCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETMyWalletIconCell.h"

@implementation ETMyWalletIconCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.backView = [[UIView alloc]init];
        [self.contentView addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(self.contentView);
            
        }];
        
        self.coinImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.coinImage];
        [self.coinImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(30);
            
        }];
    }
    
    return self;
}

- (void)setModel:(ETMyWalletLeftModel *)model {
    
    _model = model;
    
    if (model.isSelect) {
        self.coinImage.image = [UIImage imageNamed:model.selectName];
        self.backView.backgroundColor = UIColor.whiteColor;
    }else {
        self.coinImage.image = [UIImage imageNamed:model.normalName];
        self.backView.backgroundColor = UIColorFromHEX(0xF2F2F2, 1);
    }
}

@end
