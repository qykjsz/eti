//
//  ETNewChatGroupDetailsCell.m
//  ProjectET
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatGroupDetailsCell.h"

@implementation ETNewChatGroupDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETNewChatGroupDetailsDataModel *)model{
    _model = model;
    self.lab_name.text = model.name;
    if ([model.photo isEqualToString:@"lt_tjyqhy"] || [model.photo isEqualToString:@"lt_scqy"]) {
        self.img_img.image = [UIImage imageNamed:model.photo];
    }else {
        [self.img_img sd_setImageWithURL: [NSURL URLWithString:model.photo]];
    }
}

@end
