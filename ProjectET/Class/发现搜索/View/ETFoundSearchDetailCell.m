//
//  ETFoundSearchDetailCell.m
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundSearchDetailCell.h"

@implementation ETFoundSearchDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromHEX(0xf5f5f5,1);
    [self.contentView addSubview:lineView];
    WEAK_SELF(self);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        STRONG_SELF(self);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.titleLb.mas_left);
        make.right.bottom.equalTo(self.contentView);
       
    }];
    
    self.subTittleWidth.constant = SCREEN_WIDTH - 114;
    
}

- (void)setModel:(ETFoundDetailData *)model {
    
    _model = model;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.titleLb.text = model.name;
    self.subTitle.text = model.text;
}

- (void)setAppModel:(FoundCategoryApps *)appModel {
    
    _appModel = appModel;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:appModel.img]];
    self.titleLb.text = appModel.name;
    self.subTitle.text = @"阿莱空间发了；四开饭了；ask单分类；奥孔扥将；奥孔单反了；奥孔单反了；奥孔单反了； 卡塞减肥";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
