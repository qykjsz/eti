
//
//  TotalCell.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "TotalCell.h"

@implementation TotalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *typeName = [ClassBaseTools labelWithFont:16 textColor:[UIColor blueColor] textAlignment:0];
        typeName.text = @"theeopartal（ETH）";
        [self.contentView addSubview:typeName];
        [typeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(15);
        }];
        self.type = typeName;
        
        UIImageView *iconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zc_eth"]];
        [self.contentView addSubview:iconImg];
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.top.equalTo(typeName.mas_bottom).offset(5);
            make.width.mas_offset(44);
            make.height.mas_offset(44);
        }];
        self.icon = iconImg;
        
        UILabel *nameLabel = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
        nameLabel.text = @"ETH";
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImg.mas_right).offset(10);
            make.centerY.equalTo(iconImg);
        }];
        self.name = nameLabel;
        
        
        UILabel *numberLabel = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
        numberLabel.text = @"3423";
        [self.contentView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(40);
            make.right.mas_offset(-20);
        }];
        self.number = numberLabel;
        
        
        UILabel *moneyLabel = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
        moneyLabel.text = @"$ 7652.61";
        [self.contentView addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.top.equalTo(numberLabel.mas_bottom).offset(5);
        }];
        self.money = moneyLabel;
        
        UIView *line = [ClassBaseTools viewWithBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.3]];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.width.mas_offset(SCREEN_WIDTH);
            make.height.mas_offset(.5);
        }];
    }
    
    return self;
}

@end
