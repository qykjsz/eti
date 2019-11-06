//
//  ETTransferCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransferCell.h"

@implementation ETTransferCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel *moneyLb = [[UILabel alloc]init];
        moneyLb.text = @"金额";
        moneyLb.textAlignment = NSTextAlignmentLeft;
        moneyLb.font = [UIFont systemFontOfSize:11];
        moneyLb.textColor = UIColorFromHEX(0x999999, 1);
        [self.contentView addSubview:moneyLb];
        
        UILabel *statusLb = [[UILabel alloc]init];
        statusLb.text = @"状态";
        statusLb.textAlignment = NSTextAlignmentCenter;
        statusLb.font = [UIFont systemFontOfSize:11];
        statusLb.textColor = UIColorFromHEX(0x999999, 1);
        [self.contentView addSubview:statusLb];
        
        UILabel *timeLb = [[UILabel alloc]init];
        timeLb.text = @"时间";
        timeLb.textAlignment = NSTextAlignmentRight;
        timeLb.font = [UIFont systemFontOfSize:11];
        timeLb.textColor = UIColorFromHEX(0x999999, 1);
        [self.contentView addSubview:timeLb];
        
        [moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            
        }];
        
        [statusLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            
        }];
        
        [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            
        }];
        
        
        UILabel *moneydetail = [[UILabel alloc]init];
        moneydetail.text = @"289.8493";
        moneydetail.textAlignment = NSTextAlignmentLeft;
        moneydetail.font = [UIFont systemFontOfSize:14];
        moneydetail.textColor = UIColorFromHEX(0x333333, 1);
        [self.contentView addSubview:moneydetail];
        
        UILabel *statusDetail = [[UILabel alloc]init];
        statusDetail.text = @"已完成";
        statusDetail.textAlignment = NSTextAlignmentCenter;
        statusDetail.font = [UIFont systemFontOfSize:14];
        statusDetail.textColor = UIColorFromHEX(0x333333, 1);
        [self.contentView addSubview:statusDetail];
        
        UILabel *timeDetail = [[UILabel alloc]init];
        timeDetail.text = @"2019/10/22 12:23";
        timeDetail.textAlignment = NSTextAlignmentRight;
        timeDetail.font = [UIFont systemFontOfSize:14];
        timeDetail.textColor = UIColorFromHEX(0x333333, 1);
        [self.contentView addSubview:timeDetail];
        
        [moneydetail mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(moneyLb.mas_left);
            make.top.equalTo(moneyLb.mas_bottom).offset(15).priority(200);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15).priority(250);
            
        }];
        
        [statusDetail mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(moneydetail.mas_centerY);
            
        }];
        
        [timeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.centerY.equalTo(moneydetail.mas_centerY);
            
        }];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = UIColorFromHEX(0xE6E6E6, 1);
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.height.mas_equalTo(1);
        }];
    }
    
    return  self;
}

@end
