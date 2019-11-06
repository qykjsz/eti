//
//  titleCell.m
//  ETDemon
//
//  Created by hufeng on 2019/10/28.
//  Copyright © 2019 LightCould. All rights reserved.
//


#import "titleCell.h"
#import "Masonry.h"
@interface titleCell()



@end

@implementation titleCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self.contentView addSubview:self.titleLb];
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    
    return  self;
}

- (UILabel *)titleLb {
    
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.text = @"宝宝";
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.backgroundColor = UIColorFromHEX(0xE6E6E6, 1);
        _titleLb.font = [UIFont systemFontOfSize:13];
        _titleLb.textColor = UIColorFromHEX(0x666666, 1);
    }
    return _titleLb;
}


@end
