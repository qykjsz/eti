//
//  ConsultHeadView.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ConsultHeadView.h"

@implementation ConsultHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]){
        
        UIView *topView = [ClassBaseTools viewWithBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wo_top_bg"]]];
        [self addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.width.mas_offset(SCREEN_WIDTH);
            make.height.mas_offset(138);
        }];
        NSArray *titleArray = @[@"快讯",@"文章",@"行情"];
        for (int i = 0;  i< 3;  i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [topView addSubview:btn];
            [btn addTarget:self action:@selector(switchNavAtion:) forControlEvents:UIControlEventTouchUpInside];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(30+ i*(SCREEN_WIDTH-60)/3);
                make.top.mas_offset(kStatusBarHeight+5);
                make.width.mas_offset((SCREEN_WIDTH-60)/3);
            }];
        }
        
    }
    return self;
}
- (void)switchNavAtion:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(ConsultHeadViewDelegateWithClikTag:)]) {
        [self.delegate ConsultHeadViewDelegateWithClikTag:btn.tag];
    }
}
@end
