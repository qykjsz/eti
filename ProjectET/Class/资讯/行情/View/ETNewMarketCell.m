//
//  ETNewMarketCell.m
//  ProjectET
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewMarketCell.h"

@implementation ETNewMarketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETNewMarketDatasModel *)model {
    
    _model = model;
    self.lab_name.text = model.name;
    self.lab_Smoney.text = model.shangmoney;
    self.lab_xMoney.text = [NSString stringWithFormat:@"$ %@",model.xiamoney];
    [self.img_img sd_setImageWithURL:[NSURL URLWithString:model.img]];
    if ([model.zd floatValue] == 0){
        self.lab_zd.text = @"0.00";
        self.lab_zd.backgroundColor = UIColorFromHEX(0x999999, 1);
    }else if ([model.zd floatValue] < 0){
        self.lab_zd.text = [NSString stringWithFormat:@"%@%@",model.zd,@"%"];
        self.lab_zd.backgroundColor = UIColorFromHEX(0x00B794, 1);
    }else if ([model.zd floatValue] > 0){
        self.lab_zd.text = [NSString stringWithFormat:@"+%@%@",model.zd,@"%"];
        self.lab_zd.backgroundColor = UIColorFromHEX(0xE04159, 1);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
