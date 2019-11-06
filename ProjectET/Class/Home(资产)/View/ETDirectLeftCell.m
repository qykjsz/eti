//
//  ETDirectLeftCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETDirectLeftCell.h"

@implementation ETDirectLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.countLb.textColor = UIColorFromHEX(0x1D57FF, 1);
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = UIColorFromHEX(0xE6E6E6, 1);
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
