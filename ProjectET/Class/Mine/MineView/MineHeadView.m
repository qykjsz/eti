//
//  MineHeadView.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MineHeadView.h"
#import <SDWebImage/SDWebImage.h>

@implementation MineHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    UIView *topView = [ClassBaseTools viewWithBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wo_top_bg"]]];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(148);
    }];
        
    UIImageView *headImg = [[UIImageView alloc]init];
    [headImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"wo_zi_1"]];
    [topView addSubview:headImg];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.top.mas_offset(50);
        make.width.mas_offset(50);
        make.height.mas_offset(50);
    }];
        
    UILabel *name = [ClassBaseTools labelWithFont:15 textColor:[UIColor whiteColor] textAlignment:0];
    name.text = @"一条咸鱼";
    [topView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImg.mas_right).offset(15);
        make.top.equalTo(headImg).offset(5);
    }];
        
    UILabel *uid = [ClassBaseTools labelWithFont:14 textColor:[UIColor whiteColor] textAlignment:0];
    uid.text = @"uid:11111111111";
    [topView addSubview:uid];
    [uid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImg.mas_right).offset(15);
        make.top.equalTo(name.mas_bottom).offset(5);
    }];
        
    UIButton *arrBtn = [ClassBaseTools buttonWithFont:14 titlesColor:[UIColor whiteColor] contentHorizontalAlignment:2 title:@""];
    [arrBtn setImage:[UIImage imageNamed:@"wo_yjt"] forState:UIControlStateNormal];
    [arrBtn addTarget:self action:@selector(arrAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:arrBtn];
        [arrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.centerY.equalTo(headImg);
        }];
    }
    return self;
}
- (void)arrAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(MineHeadViewDelegateWithClikTag:)]) {
        [self.delegate MineHeadViewDelegateWithClikTag:btn.tag];
    }
}
@end
