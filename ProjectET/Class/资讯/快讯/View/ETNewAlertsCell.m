//
//  ETNewAlertsCell.m
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewAlertsCell.h"

@implementation ETNewAlertsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETNewConalertNewsListData *)model {
    
    _model = model;
    self.lab_time.text = [self getTimeFromTimestamp:model.time];
    self.lab_title.text = model.title;
    self.lab_conten.text = model.content;
    self.lab_source.text = [NSString stringWithFormat:@"来源：%@",model.source];
    if ([model.islook isEqual: @"0"]) {
        [self.lab_conten setNumberOfLines:4];
        [self.lab_all setHidden:NO];
        
    }else {
        [self.lab_conten setNumberOfLines:0];
         [self.lab_all setHidden:YES];
    }
}


- (IBAction)actionOfShare:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ETNewAlertsCellDelegateWithShare:)]) {
        [self.delegate ETNewAlertsCellDelegateWithShare:self.model];
    }
}


#pragma mark ---- 将时间戳转换成时间

- (NSString *)getTimeFromTimestamp:(NSString *)time{
    
    //将对象类型的时间转换为NSDate类型
    
    //    double time =1504667976;
    
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    
    //设置时间格式
    
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    
    //将时间转换为字符串
    
    NSString *timeStr=[formatter stringFromDate:myDate];
    
    return timeStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
