//
//  MineRecordCell.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MineRecordCell.h"

@implementation MineRecordCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *nodeName = [ClassBaseTools labelWithFont:16 textColor:[UIColor blueColor] textAlignment:0];
        nodeName.text = @"转出ETH";
        [self.contentView addSubview:nodeName];
        [nodeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(20);
        }];
        self.recordName = nodeName;
        
        NSArray *labelArray = @[@"金额",@"状态",@"时间"];
        for (int i = 0;  i < 3;  i++) {
            
            UILabel *label = [ClassBaseTools labelWithFont:13 textColor:[UIColor grayColor] textAlignment:i];
            label.text = labelArray[i];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15+ i*(SCREEN_WIDTH-30)/3);
                make.top.equalTo(nodeName.mas_bottom).offset(10);
                make.width.mas_offset((SCREEN_WIDTH-30)/3);
            }];
        }
        
        
        UILabel *moneyValue = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
        moneyValue.text = @"123";
        [self.contentView addSubview:moneyValue];
        [moneyValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.bottom.equalTo(self.mas_bottom).offset(-11);
        }];
        self.moneyValue = moneyValue;
        
        
        UILabel *stateValue = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
        stateValue.text = @"完成";
        [self.contentView addSubview:stateValue];
        [stateValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(moneyValue);
        }];
        self.stateValue = stateValue;
        
        
        UILabel *timeValue = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
        timeValue.text = @"12:23";
        [self.contentView addSubview:timeValue];
        [timeValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.centerY.equalTo(moneyValue);
        }];
        self.timeValue = timeValue;
        
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
