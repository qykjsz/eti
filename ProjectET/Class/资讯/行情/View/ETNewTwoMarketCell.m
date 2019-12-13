//
//  ETNewTwoMarketCell.m
//  ProjectET
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewTwoMarketCell.h"

@implementation ETNewTwoMarketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETNewMarketDatasModel *)model {
    
    _model = model;
    self.lab_name.text = model.name;
    self.lab_allName.text = model.allname;
    self.lab_vol.text = [NSString stringWithFormat:@"$ %@",model.shizhi];
    self.lab_circulation.text = [NSString stringWithFormat:@"$ %@",model.vol] ;
    self.lab_xiamoney.text = [NSString stringWithFormat:@"$ %@",model.xiamoney];
    if ([model.zd floatValue] == 0){
        self.lab_zd.text = @"0.00";
        self.lab_zd.textColor = UIColorFromHEX(0x999999, 1);
        self.lab_xiamoney.textColor = UIColorFromHEX(0x999999, 1);
    }else if ([model.zd floatValue] < 0){
        self.lab_zd.text = [NSString stringWithFormat:@"%@%@",model.zd,@"%"];
        self.lab_zd.textColor = UIColorFromHEX(0xE04159, 1);
        self.lab_xiamoney.textColor = UIColorFromHEX(0xE04159, 1);
    }else if ([model.zd floatValue] > 0){
        self.lab_zd.text = [NSString stringWithFormat:@"+%@%@",model.zd,@"%"];
        self.lab_zd.textColor = UIColorFromHEX(0x00B794, 1);
        self.lab_xiamoney.textColor = UIColorFromHEX(0x00B794, 1);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
