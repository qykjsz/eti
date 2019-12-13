//
//  ETTopupCenterRecordCell.m
//  ProjectET
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTopupCenterRecordCell.h"

@implementation ETTopupCenterRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(ETTopupCenterRecordOrderModel *)model {
    
    _model = model;
    self.lab_gameName.text = model.gamename;
    self.lab_gameUser.text = [NSString stringWithFormat:@"(%@)",model.gameuser];
    self.lab_gameNumber.text = [NSString stringWithFormat:@"+%@",model.gamenumber];
    self.lab_state.text = model.state;
    self.lab_time.text = model.time;
    self.lab_money.text = [NSString stringWithFormat:@"-%@ %@",model.money,model.moneystate];
    if ([model.color isEqualToString:@"0"]) {
        self.lab_state.textColor = UIColorFromHEX(0x24CE94, 1);
    }else {
        self.lab_state.textColor = UIColorFromHEX(0xB7BCDC, 1);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
