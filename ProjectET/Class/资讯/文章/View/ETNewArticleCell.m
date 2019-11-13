//
//  ETNewArticleCell.m
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewArticleCell.h"

@implementation ETNewArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETNewArticleDNewModel *)model {
    
    _model = model;
    self.lab_title.text = model.name;
    self.lab_time.text = model.time;
    [self.img_img sd_setImageWithURL:[NSURL URLWithString:model.img]];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
