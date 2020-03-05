//
//  ETTransferCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransferCell.h"

@interface ETTransferCell()

@property (nonatomic,strong) UILabel *moneydetail;

@property (nonatomic,strong) UILabel *statusDetail;

@property (nonatomic,strong) UILabel *timeDetail;

@end

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
    
    _model = model;
    self.moneydetail.text = [NSString stringWithFormat:@"%.4f %@",[model.amount floatValue],model.name];
    NSInteger type = [model.status integerValue];
    if (type == 1) {
        self.statusDetail.text = @"已完成";
    }else{
        self.statusDetail.text = @"失败";
    }
    
    self.timeDetail.text = model.time;
}

@end
