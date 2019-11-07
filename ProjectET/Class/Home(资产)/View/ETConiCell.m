//
//  ETConiCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETConiCell.h"

@implementation ETConiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sy_zc_dk-1"]];
        [self.contentView addSubview:backImage];
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).offset(13);
            make.right.equalTo(self.contentView.mas_right).offset(-13);
            make.height.mas_equalTo(70);
//            make.centerY.equalTo(self.contentView.mas_centerY);
            make.top.equalTo(self.contentView.mas_top);
            
        }];
        
        [self.contentView addSubview:self.coninImage];
        [self.coninImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(backImage.mas_centerY);
            make.width.height.mas_equalTo(44);
            make.left.equalTo(backImage.mas_left).offset(25);
            
        }];
        
        [self.contentView addSubview:self.coninName];
        [self.coninName mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.coninImage.mas_right).offset(15);
            make.centerY.equalTo(self.coninImage.mas_centerY);
            
        }];
        
        
        [self.contentView addSubview:self.topDollor];
        [self.topDollor mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(backImage.mas_top).offset(15);
            make.right.equalTo(backImage.mas_right).offset(-25);
            
        }];
        
        [self.contentView addSubview:self.bottomDollor];
        [self.bottomDollor mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(backImage.mas_bottom).offset(-15);
            make.right.equalTo(backImage.mas_right).offset(-25);
            
        }];
    }
    
    return self;
}

- (void)setModel:(glodData *)model {

    
    _model = model;

    if ([model.name isEqualToString:@"ETH"]) {
        self.coninImage.image = [UIImage imageNamed:@"sy_eth"];
    }else  {
        self.coninImage.image = [UIImage imageNamed:@"sy_usdt"];
    }
    
//    self.topDollor.text = model.number;
//    self.bottomDollor.text = [NSString stringWithFormat:@"$ %@",model.usdtnumber];
    
}

- (UILabel *)coninName {
    
    if (!_coninName) {
        _coninName = [[UILabel alloc]init];
        _coninName.font = [UIFont systemFontOfSize:20];
        _coninName.textColor = UIColorFromHEX(0x333333, 1);
    }
    return _coninName;
}

- (UIImageView *)coninImage {
    
    if (!_coninImage) {
        _coninImage = [[UIImageView alloc]init];
        _coninImage.clipsToBounds = YES;
        _coninImage.layer.cornerRadius = 22;
    }
    return _coninImage;
}

- (UILabel *)topDollor {
    
    if (!_topDollor) {
        _topDollor = [[UILabel alloc]init];
        _topDollor.font = [UIFont systemFontOfSize:20];
        _topDollor.text = @"22.8862";
        _topDollor.textColor = UIColorFromHEX(0x333333, 1);
    }
    return _topDollor;
}

- (UILabel *)bottomDollor {
    
    if (!_bottomDollor) {
        _bottomDollor = [[UILabel alloc]init];
        _bottomDollor.font = [UIFont systemFontOfSize:12];
        _bottomDollor.text = @"$ 7652.61";
        _bottomDollor.textColor = UIColorFromHEX(0x99AFD9, 1);
    }
    return _bottomDollor;
}

@end
