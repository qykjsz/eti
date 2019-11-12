//
//  AlertsCell.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "AlertsCell.h"

@implementation AlertsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *titleName = [ClassBaseTools labelWithFont:14 textColor:[UIColor blackColor] textAlignment:0];
        titleName.numberOfLines = 0;
        [self.contentView addSubview:titleName];
        [titleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(24);
            make.right.mas_offset(-136);
            make.height.mas_offset(50);
        }];
        self.title = titleName;
        
        
        UILabel *fromAddress = [ClassBaseTools labelWithFont:13 textColor:[UIColor grayColor] textAlignment:0];
        [self.contentView addSubview:fromAddress];
        [fromAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];
        self.from = fromAddress;
        
        
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"wz_pic"];
        [self.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_offset(110);
            make.height.mas_offset(84);
        }];
        self.img = img;
        
    
    }
    
    return self;
}

@end
