//
//  ETTableHeaderSelectView.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTableHeaderSelectView.h"
#import "UIButton+ImageTitleSpacing.h"
@implementation ETTableHeaderSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        NSArray *titleArr = @[@"资源",@"投票",@"币买卖",@"更多工具"];
        NSArray *photoArr = @[@"sy_ziyuan",@"sy_toupiao",@"sy_maibi",@"sy_more"];
        for (int i = 0; i<4; i++) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [btn setTitleColor:UIColorFromHEX(0x333333, 1) forState:UIControlStateNormal];
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setImage:[UIImage imageNamed:photoArr[i]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"kj_kp_d"] forState:UIControlStateNormal];
            [self addSubview:btn];
            
            NSInteger btnW = (SCREEN_WIDTH - 30 - 36)/4;
            
            btn.frame = CGRectMake(15 + i*15 + i*btnW, 10, btnW, btnW);
            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    
    return self;
}

- (void)btnClick:(UIButton *)sender {
    
    
}
@end
