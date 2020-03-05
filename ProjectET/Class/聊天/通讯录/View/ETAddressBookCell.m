//
//  ETAddressBookCell.m
//  ProjectET
//
//  Created by mac on 2020/1/3.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETAddressBookCell.h"

@implementation ETAddressBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETAddressBookDataModel *)model {
    
    _model = model;
    self.lab_name.text = model.name;
   
    if ([model.photo isEqualToString:@""]) {
        self.img_igm.image = [UIImage imageNamed:@""];
        self.lab_msg.text = model.code;
        self.lab_titleTitle.text = [model.name substringToIndex:1];;
        self.img_igm.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    }else {
        self.lab_msg.text = model.address;
        self.lab_titleTitle.text = @"";
         [self.img_igm sd_setImageWithURL: [NSURL URLWithString:model.photo]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
