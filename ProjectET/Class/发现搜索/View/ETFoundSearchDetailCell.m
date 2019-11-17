//
//  ETFoundSearchDetailCell.m
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundSearchDetailCell.h"

@implementation ETFoundSearchDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromHEX(0xf5f5f5,1);
    [self.contentView addSubview:lineView];
    WEAK_SELF(self);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        STRONG_SELF(self);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.titleLb.mas_left);
        make.right.bottom.equalTo(self.contentView);
        
    }];
}

- (void)setModel:(ETFoundDetailData *)model {
    
    _model = model;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.titleLb.text = model.name;
    self.subTitle.text = model.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
