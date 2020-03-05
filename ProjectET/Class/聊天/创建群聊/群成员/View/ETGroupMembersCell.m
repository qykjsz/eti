//
//  ETGroupMembersCell.m
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETGroupMembersCell.h"

@implementation ETGroupMembersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETGroupMembersDataModel *)model {
    
    _model = model;
    self.lab_name.text = model.name;
    [self.img_img sd_setImageWithURL: [NSURL URLWithString:model.photo]];
    if ([model.shenfen isEqualToString:@"1"]) {
        [self.btn_shenfen setHidden:NO];
    }else {
        [self.btn_shenfen setHidden:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
