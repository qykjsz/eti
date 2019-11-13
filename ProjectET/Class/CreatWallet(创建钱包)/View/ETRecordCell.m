//
//  ETRecordCell.m
//  ProjectET
//
//  Created by hufeng on 2019/11/1.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETRecordCell.h"

@interface ETRecordCell()




@end

@implementation ETRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.topLB = [[UILabel alloc]init];
        self.topLB.text = @"转出ETH";
        self.topLB.font = [UIFont systemFontOfSize:14];
        self.topLB.textColor = UIColorFromHEX(0x00C176, 1);
        [self.contentView addSubview:self.topLB];
        [self.topLB mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            
        }];
        
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
            make.top.equalTo(self.topLB.mas_bottom).offset(15);
            
        }];
        
        [statusLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.contentView.mas_centerX);
//            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.centerY.equalTo(moneyLb.mas_centerY);
            
        }];
        
        [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right).offset(-15);
//            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.centerY.equalTo(moneyLb.mas_centerY);
            
        }];
        
        
        self.moneydetail = [[UILabel alloc]init];
        self.moneydetail.text = @"289.8493";
        self.moneydetail.textAlignment = NSTextAlignmentLeft;
        self.moneydetail.font = [UIFont systemFontOfSize:14];
        self.moneydetail.textColor = UIColorFromHEX(0x333333, 1);
        [self.contentView addSubview:self.moneydetail];
        
        self.statusDetail = [[UILabel alloc]init];
        self.statusDetail.text = @"已完成";
        self.statusDetail.textAlignment = NSTextAlignmentCenter;
        self.statusDetail.font = [UIFont systemFontOfSize:14];
        self.statusDetail.textColor = UIColorFromHEX(0x333333, 1);
        [self.contentView addSubview:self.statusDetail];
        
        self.timeDetail = [[UILabel alloc]init];
        self.timeDetail.text = @"2019/10/22 12:23";
        self.timeDetail.textAlignment = NSTextAlignmentRight;
        self.timeDetail.font = [UIFont systemFontOfSize:14];
        self.timeDetail.textColor = UIColorFromHEX(0x333333, 1);
        [self.contentView addSubview:self.timeDetail];
        
        [self.moneydetail mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(moneyLb.mas_left);
            make.top.equalTo(moneyLb.mas_bottom).offset(15).priority(200);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15).priority(250);
            
        }];
        
        [self.statusDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.moneydetail.mas_centerY);
            
        }];
        
        [self.timeDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.centerY.equalTo(self.moneydetail.mas_centerY);
            
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

- (void)setModel:(orderData *)model {
    // order->type    [string]    是    类型 1.转入 2.转出
    _model = model;
    if ([model.type isEqualToString:@"1"]) {
        self.topLB.textColor = UIColorFromHEX(0x1D57FF, 1);
        self.topLB.text = [NSString stringWithFormat:@"转入%@",model.name];
    }else {
         self.topLB.textColor = UIColorFromHEX(0x00C176, 1);
        self.topLB.text = [NSString stringWithFormat:@"转入%@",model.name];
    }
    
    self.moneydetail.text = model.amount;
//    order->status    [string]    是    状态 1.成功 2.失败
    NSInteger status = [model.status integerValue];
    if (status == 1) {
        self.statusDetail.text = @"已完成";
    }else {
        self.statusDetail.text = @"失败";
    }
    
    self.timeDetail.text = model.time;
    
}

- (void)setData:(hashData *)data {
    
    _data = data;
    if ([data.type isEqualToString:@"1"]) {
        self.topLB.textColor = UIColorFromHEX(0x1D57FF, 1);
        self.topLB.text = [NSString stringWithFormat:@"转入%@",data.name];
    }else {
        self.topLB.textColor = UIColorFromHEX(0x00C176, 1);
        self.topLB.text = [NSString stringWithFormat:@"转入%@",data.name];
    }
    
    self.moneydetail.text = data.amount;
    //    order->status    [string]    是    状态 1.成功 2.失败
    NSInteger status = [data.status integerValue];
    if (status == 1) {
        self.statusDetail.text = @"已完成";
    }else {
        self.statusDetail.text = @"失败";
    }
    
    self.timeDetail.text = data.time;
    
}

@end
