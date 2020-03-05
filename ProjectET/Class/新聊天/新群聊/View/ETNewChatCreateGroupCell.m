//
//  ETNewChatCreateGroupCell.m
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatCreateGroupCell.h"

@implementation ETNewChatCreateGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)reloadCellForDic:(NSDictionary *)dic{
    [self.img_img sd_setImageWithURL: [NSURL URLWithString:dic[@"photo"]]];
    if ([dic[@"remarks"] isEqualToString:@""]) {
          self.lab_name.text = dic[@"name"];
      }else {
          self.lab_name.text = dic[@"remarks"];
      }
    if ([dic[@"sel"] isEqualToString:@"0"]) {
        self.img_sel.image = [UIImage imageNamed:@"lt_xzlxr_wxz"];
    }else {
        self.img_sel.image = [UIImage imageNamed:@"lt_xzcy_icon"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
