//
//  ETShopRecordCell.m
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETShopRecordCell.h"

@implementation ETShopRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETShopRecordOrderModel *)model {
    
    _model = model;
    [self.lab_from setLineBreakMode:NSLineBreakByTruncatingMiddle];
    self.lab_from.text = model.from;
    self.lab_time.text = model.time;
    self.lab_type.text = model.type;
    self.lab_fimoney.text = [NSString stringWithFormat:@"+%@ %@",model.fimoney,model.fimoneyname];
     self.lab_money.text = [NSString stringWithFormat:@"≈%@ %@",model.money,model.moneyname];
    if ([model.color isEqualToString:@"1"]) {
        self.lab_type.textColor = UIColorFromHEX(0x24CE94, 1);
    }else {
        self.lab_type.textColor = UIColorFromHEX(0xB7BCDC, 1);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
