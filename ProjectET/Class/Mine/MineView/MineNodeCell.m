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
       
        UILabel *nodeName = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
        [self.contentView addSubview:nodeName];
        [nodeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(10);
        }];
        self.nodeName = nodeName;
        
        
        UILabel *nodeAddress = [ClassBaseTools labelWithFont:15 textColor:[UIColor grayColor] textAlignment:0];
        [self.contentView addSubview:nodeAddress];
        [nodeAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.equalTo(nodeName.mas_bottom).offset(5);
        }];
        self.nodeAddress = nodeAddress;
        
        
        UILabel *speed = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
        speed.text = @"403ms";
        [self.contentView addSubview:speed];
        [speed mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-50);
            make.centerY.equalTo(self.contentView);
        }];
        self.speed = speed;
        
        
        UILabel *point = [ClassBaseTools labelWithFont:30 textColor:[UIColor greenColor] textAlignment:0];
        point.text = @"·";
        [self.contentView addSubview:point];
        [point mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.centerY.equalTo(self.contentView);
        }];
        self.point = point;
    }
    
    return self;
}



@end
