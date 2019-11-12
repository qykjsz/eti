//
//  ETProclamListCell.m
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETProclamListCell.h"

@implementation ETProclamListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.docView = [[UIView alloc]init];
        self.docView.clipsToBounds = YES;
        self.docView.layer.cornerRadius = 3;
        self.docView.backgroundColor = UIColorFromHEX(0x1B5BFB, 1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        WEAK_SELF(self);
        [self.contentView addSubview:self.docView];
        [self.docView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(24);
            make.width.height.mas_equalTo(6);
            
        }];
        
        self.titleLb = [[UILabel alloc]init];
        self.titleLb.font = [UIFont systemFontOfSize:14];
        self.titleLb.textColor = UIColorFromHEX(0x333333, 1);
        [self.contentView addSubview:self.titleLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.docView.mas_right).offset(15);
            make.centerY.equalTo(self.docView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-50);
            
        }];
        
        self.timeLb = [[UILabel alloc]init];
        self.timeLb.font = [UIFont systemFontOfSize:11];
        self.timeLb.textColor = UIColorFromHEX(0x99AFD9, 1);
        [self.contentView addSubview:self.timeLb];
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.top.equalTo(self.titleLb.mas_bottom).offset(5);
            make.left.equalTo(self.docView.mas_right).offset(15);
            
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = UIColorFromHEX(0xDBDBDB, 1);
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.height.mas_equalTo(0.5);
            
        }];
        
        UIImageView *arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zc_yjt"]];
        [self.contentView addSubview:arrowImage];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.mas_equalTo(7);
            make.height.mas_equalTo(12);
            
        }];
    }
    
    return self;
    
}

- (void)setModel:(ETNewsData *)model {
    
    _model = model;
    self.timeLb.text = model.time;
    self.titleLb.text = model.name;
    
}
@end
