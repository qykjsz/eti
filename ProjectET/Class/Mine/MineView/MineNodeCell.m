//
//  MineNodeCell.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MineNodeCell.h"

@implementation MineNodeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        UILabel *nodeName = [ClassBaseTools labelWithFont:15 textColor:UIColorFromHEX(0x333333, 1) textAlignment:0];
        [self.contentView addSubview:nodeName];
        [nodeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(10);
        }];
        self.nodeName = nodeName;
        
        UILabel *point = [ClassBaseTools labelWithFont:30 textColor:[UIColor greenColor] textAlignment:0];
        point.text = @"·";
        [self.contentView addSubview:point];
        [point mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(- 20);
            make.centerY.equalTo(self.contentView);
        }];
        self.point = point;
        
        UILabel *speed = [ClassBaseTools labelWithFont:15 textColor:UIColorFromHEX(0x333333, 1) textAlignment:0];
        [self.contentView addSubview:speed];
        [speed mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(point.mas_left).offset(-10);
            make.centerY.equalTo(self.contentView);
        }];
        self.speed = speed;
        
        
        UILabel *nodeAddress = [ClassBaseTools labelWithFont:15 textColor:UIColorFromHEX(0x999999, 1) textAlignment:0];
        [self.contentView addSubview:nodeAddress];
        [nodeAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.right.lessThanOrEqualTo(speed.mas_left).offset(- 10);
            make.top.equalTo(nodeName.mas_bottom).offset(5);
        }];
        self.nodeAddress = nodeAddress;
        
        
       
        
     
    }
    
    return self;
}



@end
