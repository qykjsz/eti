//
//  MarketCell.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MarketCell.h"

@implementation MarketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *iconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zc_eth"]];
        [self.contentView addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.centerY.equalTo(self.contentView);
            make.width.mas_offset(44);
            make.height.mas_offset(44);
        }];
        self.icon = iconImg;
        
        UILabel *nameLabel = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
        nameLabel.text = @"ETH";
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImg.mas_right).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.mas_offset(100);
            make.height.mas_offset(15);
        }];
        self.name= nameLabel;
        
        UILabel *number = [ClassBaseTools labelWithFont:14 textColor:[UIColor blackColor] textAlignment:0];
        
        number.text = @"78.99";
        [self.contentView addSubview:number];
        [number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.mas_offset(15);
            make.height.mas_offset(15);
        }];
        self.number = number;
        
        UILabel *money = [ClassBaseTools labelWithFont:13 textColor:[UIColor grayColor] textAlignment:0];
        money.text = @"$ 3.8399";
        [self.contentView addSubview:money];
        [money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(number);
            make.top.equalTo(number.mas_bottom).offset(5);
        }];
        self.money = money;
        
        UILabel *gains = [ClassBaseTools labelWithFont:15 textColor:[UIColor blueColor] textAlignment:0];
        [self.contentView addSubview:gains];
        [gains mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.centerY.equalTo(iconImg);
        }];
        gains.backgroundColor = [UIColor greenColor];
        gains.text = @"+ 1.86%";
    }
    
    return self;
}

@end
