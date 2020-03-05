//
//  ETNewChatMineGroupCell.m
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatMineGroupCell.h"

@implementation ETNewChatMineGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETNewChatMineGroupDataModel *)model{
    _model = model;
    [self.img_img sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    self.lab_name.text = model.name;
    self.lab_number.text = [NSString stringWithFormat:@"(%@人)",model.number];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
