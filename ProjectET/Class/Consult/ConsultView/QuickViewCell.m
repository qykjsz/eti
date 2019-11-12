//
//  QuickViewCell.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "QuickViewCell.h"

@implementation QuickViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *topImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kx_jianb"]];
        [self.contentView addSubview:topImg];
        [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(24);
            make.top.mas_offset(10);
            make.width.mas_offset(124.5);
            make.height.mas_offset(36);
        }];
        
        UILabel *timeLabel = [ClassBaseTools labelWithFont:11 textColor:[UIColor whiteColor] textAlignment:0];
        timeLabel.text = @"2019/10/24 11:12";
        [topImg addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_offset(0);
            make.width.mas_offset(100);
            make.height.mas_offset(36);
        }];
        self.time= timeLabel;
        
        UILabel *titleName = [ClassBaseTools labelWithFont:14 textColor:[UIColor blackColor] textAlignment:0];
        titleName.numberOfLines = 0;
        titleName.text = @"采用领先国际的流式端到端语音语言一体化建模方SMLTA，结合中文语义理解智能纠错，近场中文普通话识别准确率达98% ,可通过上";
        [self.contentView addSubview:titleName];
        [titleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topImg);
            make.top.equalTo(topImg.mas_bottom).offset(5);
            make.right.mas_offset(-15);
        }];
        self.title = titleName;
        
        UILabel *detailLabel = [ClassBaseTools labelWithFont:13 textColor:[UIColor grayColor] textAlignment:0];
        detailLabel.numberOfLines = 0;
        [self.contentView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleName);
            make.top.equalTo(titleName).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        self.detail = detailLabel;
        
        UILabel *from = [ClassBaseTools labelWithFont:13 textColor:[UIColor blueColor] textAlignment:0];
        [self.contentView addSubview:from];
        [from mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(detailLabel);
            make.top.equalTo(self.contentView.mas_bottom).offset(-20);
        }];
        from.text = @"来源：MOMO";
    }
    
    return self;
}


@end
