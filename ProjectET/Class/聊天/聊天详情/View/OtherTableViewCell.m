//
//  OtherTableViewCell.m
//  ChatWithEachOther
//
//  Created by MJ on 2017/8/10.
//  Copyright © 2017年 韩明静. All rights reserved.
//

#import "OtherTableViewCell.h"
#import "Masonry.h"

@implementation OtherTableViewCell

-(UIImageView *)iconImageView{
    
    if (_iconImageView==nil) {
        _iconImageView=[UIImageView new];
        _iconImageView.layer.cornerRadius=25;
        _iconImageView.layer.masksToBounds=YES;
        _iconImageView.image=[UIImage imageNamed:@"haoyou"];
    }
    return _iconImageView;
}

-(UILabel *)nameLabel{
    
    if (_nameLabel==nil) {
        _nameLabel=[UILabel new];
        _nameLabel.textColor=[UIColor lightGrayColor];
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _nameLabel;
}

-(UILabel *)contentLabel{
    
    if (_contentLabel==nil) {
        _contentLabel=[UILabel new];
        _contentLabel.font=[UIFont systemFontOfSize:15];
        _contentLabel.numberOfLines=0;
    }
    return _contentLabel;
}

-(UIImageView *)bgImageView{
    
    if (_bgImageView==nil) {
        _bgImageView=[UIImageView new];
        _bgImageView.backgroundColor = UIColorFromHEX(0xFFFFFF, 1);
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.layer.cornerRadius = 10;
//        _bgImageView.image=[UIImage imageNamed:@"chat_recive_nor"];
    }
    return _bgImageView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor= UIColorFromHEX(0xEBEBEB, 1);
        
        [self prepareSubviews];
    }
    
    return self;
}

-(void)prepareSubviews{
    
    __weak typeof(self) weakSelf=self;
    
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.contentView).offset(15);
        make.width.height.equalTo(@50);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImageView);
        make.height.equalTo(@13);
         make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.leading.equalTo(weakSelf.iconImageView.mas_trailing).offset(8);
    }];
    
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.nameLabel);
        make.trailing.equalTo(weakSelf.contentView).offset(-100);
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        make.bottom.equalTo(weakSelf.contentView).offset(-8);
    }];
    
    [self.bgImageView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgImageView).offset(15);
        make.top.equalTo(weakSelf.bgImageView);
        make.centerX.equalTo(weakSelf.bgImageView);
        make.bottom.equalTo(weakSelf.bgImageView);
    }];
}


@end
