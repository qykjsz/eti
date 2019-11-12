//
//  ETHomeTableHeaderView.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETHomeTableHeaderView.h"
#import "ETNoticeScrollView.h"
#import "ETTableHeaderSelectView.h"

#import "ETHomeModel.h"

@implementation ETHomeTableHeaderView

- (void)clickAction {
    
    if ([self.delegate respondsToSelector:@selector(ETHomeTableHeaderViewDelegateClickAction)]) {
        [self.delegate ETHomeTableHeaderViewDelegateClickAction];
    }
}

- (instancetype)initWithFrame:(CGRect)frame andProgress:(NSMutableArray *)progress {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction)];
        [self addGestureRecognizer:tap];
        
        UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sy_qb_bg"]];
        [self addSubview:backImage];
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(20);
            make.width.mas_equalTo(SCREEN_WIDTH - 30);
            make.height.mas_equalTo(220);
            
        }];
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.text = @"资产正在保护中";
        titleLb.font = [UIFont systemFontOfSize:12];
        titleLb.textColor = UIColorFromHEX(0x1A59FB, 1);
        [backImage addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(backImage.mas_right).offset(-10);
            make.top.equalTo(backImage.mas_top);
            make.height.mas_equalTo(35);
            
        }];
        
        UIImageView *titileImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sy_anquan"]];
        [backImage addSubview:titileImage];
        [titileImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(titleLb.mas_centerY);
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(15);
            make.right.equalTo(titleLb.mas_left).offset(-10);
            
        }];
        
        [self addSubview:self.tipsLb];
        [self.tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(backImage.mas_top).offset(40);
            make.left.equalTo(backImage.mas_left).offset(15);
            
        }];
        
        [self addSubview:self.eyeBtn];
        [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.tipsLb.mas_centerY);
            make.left.equalTo(self.tipsLb.mas_right).offset(10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(13);
            
        }];
        
        [self addSubview:self.moneyLb];
        [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.tipsLb.mas_bottom).offset(15);
            make.left.equalTo(backImage.mas_left).offset(15);
            
        }];
        
        UIImageView *iamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sy_yjt"]];
        [backImage addSubview:iamge];
        [iamge mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.moneyLb.mas_bottom);
            make.width.height.mas_equalTo(22);
            make.right.equalTo(backImage.mas_right).offset(-15);
            
        }];
        
        [self addSubview:self.todayLb];
        [self.todayLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.moneyLb.mas_bottom).offset(22);
            make.left.equalTo(backImage.mas_left).offset(15);
            
        }];
        
        NSInteger top = 190;
        NSInteger left = 30;
        NSInteger lineWidth = SCREEN_WIDTH - 70;
        
        NSMutableArray *colorArr = [NSMutableArray array];
        for (int i = 0; i<progress.count; i++) {
            proportionData *data = progress[i];
            UIColor *color = [Tools getRandomColor];
            [colorArr addObject:color];
            data.color = color;
//            if (i == 0) {
//                 data.bili = [NSString stringWithFormat:@"%.1f",12.0];
//            }else if (i == 1) {
//                data.bili = [NSString stringWithFormat:@"%.1f",30.0];
//            }else {
//                data.bili = [NSString stringWithFormat:@"%.1f",58.0];
//            }
        }
        // 第一根背景色为黑色的进度条，只做展示，方便后面的叠加
        UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(left, top, lineWidth, 4)];
        grayView.clipsToBounds = YES;
        grayView.layer.cornerRadius = 2;
        grayView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
        [self addSubview:grayView];
        
        // 为数组排序,把最大的放在第一个
        NSArray *resultStrArray = [progress sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            proportionData *model1 = obj1;
            proportionData *model2 = obj2;
            NSComparisonResult result = [model1.bili localizedStandardCompare:model2.bili];
            return  result == NSOrderedAscending; // 升序
            //        return  result == NSOrderedSame; // 不变
            //        return result == NSOrderedAscending;  // 降序
        }];
        NSLog(@"%@",resultStrArray);
        
        for (int i = 0 ; i<resultStrArray.count; i++) {
            proportionData *data = resultStrArray[i];
            CGFloat width = [data.bili floatValue]/100;
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(0, 0, width*lineWidth, 4);
            lineView.backgroundColor = data.color;
            [grayView addSubview:lineView];
        }
    
        
        for (int i = 0; i<progress.count; i++) {
            
            proportionData *data = progress[i];
            
            NSString *textString = [NSString stringWithFormat:@"·%@ %@%%",data.name,data.bili];
            UILabel *detailLb = [[UILabel alloc]init];
            
            detailLb.textColor = UIColorFromHEX(0xF5F5F5, 1);
            detailLb.font = [UIFont systemFontOfSize:10];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:textString];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:colorArr[i]
                                  range:NSMakeRange(0, 1)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:UIColor.whiteColor
                                  range:NSMakeRange(1, textString.length - 1)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:10]
                                  range:NSMakeRange(0 , textString.length - 1)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:30]
                                  range:NSMakeRange(0 , 1)];
            [AttributedStr addAttribute:NSBaselineOffsetAttributeName value:@(-7) range:NSMakeRange(0, 1)];
            detailLb.attributedText = AttributedStr;
            detailLb.frame = CGRectMake(20 + i*5 + 80*i, 200, 80, 25);
            [self addSubview:detailLb];
            
        }
        
        
        UIImageView *lunboImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sy_gong"]];
        [self addSubview:lunboImage];
        [lunboImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(backImage.mas_bottom).offset(20);
            make.width.mas_equalTo(57);
            make.height.mas_equalTo(15);
            
        }];
        
        
        self.scrollView = [[ETNoticeScrollView alloc]initWithFrame:CGRectMake(82, 260, 220, 15)];
        [self addSubview:self.scrollView];
        
        
        UIButton *moreBtn = [[UIButton alloc]init];
        moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -60);
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [moreBtn setTitleColor:UIColorFromHEX(0x1758FB, 1) forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(lunboImage.mas_centerY);
            make.width.equalTo(@100);
            make.height.equalTo(@12);
        }];
        
        ETTableHeaderSelectView *selectView = [ETTableHeaderSelectView new];
        [self addSubview:selectView];
        [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left);
            make.top.equalTo(lunboImage.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo((SCREEN_WIDTH - 30 -36)/4 + 20);
        }];
    }
    
    return self;
}

- (void)moreClick {
    if ([self.delegate respondsToSelector:@selector(ETHomeTableHeaderViewDelegateMoreClickAction)]) {
        [self.delegate ETHomeTableHeaderViewDelegateMoreClickAction];
    }
}


- (void)setContentArr:(NSArray *)contentArr {
    
    _contentArr = contentArr;
    
    [self.scrollView setContents:contentArr];
    
}

#pragma Mark -lazy load
- (UILabel *)tipsLb {
    
    if (!_tipsLb) {
        _tipsLb = [[UILabel alloc]init];
        _tipsLb.font = [UIFont systemFontOfSize:13];
        _tipsLb.textColor = UIColorFromHEX(0xF5F5F5, 1);
        _tipsLb.text = @"我的总资产（$)";
    }
    return _tipsLb;
}

- (UILabel *)moneyLb {
    
    if (!_moneyLb) {
        _moneyLb = [[UILabel alloc]init];
        _moneyLb.font = [UIFont systemFontOfSize:33];
        _moneyLb.textColor = UIColorFromHEX(0xF5F5F5, 1);
        _moneyLb.text = @"999.99";
    }
    return _moneyLb;
}

- (UILabel *)todayLb {
    
    if (!_todayLb) {
        _todayLb = [[UILabel alloc]init];
        _todayLb.font = [UIFont systemFontOfSize:13];
        _todayLb.textColor = UIColorFromHEX(0xF5F5F5, 1);
        _todayLb.text = @"今日 +120.36";
    }
    return _todayLb;
}

- (UILabel *)ETLB {
    
    if (!_ETLB) {
        _ETLB = [[UILabel alloc]init];
        _ETLB.font = [UIFont systemFontOfSize:10];
        _ETLB.textColor = UIColorFromHEX(0xF5F5F5, 1);
        _ETLB.text = @"· ET 80%";
    }
    return _ETLB;
}

- (UILabel *)ETHLB {
    
    if (!_ETHLB) {
        _ETHLB = [[UILabel alloc]init];
        _ETHLB.font = [UIFont systemFontOfSize:10];
        _ETHLB.textColor = UIColorFromHEX(0xF5F5F5, 1);
        _ETHLB.text = @"· ETH 80%";
    }
    return _ETHLB;
}

- (UIButton *)eyeBtn {
    
    if (!_eyeBtn) {
        _eyeBtn = [[UIButton alloc]init];
        [_eyeBtn setImage:[UIImage imageNamed:@"sy_yincang"] forState:UIControlStateNormal];
        [_eyeBtn setImage:[UIImage imageNamed:@"sy_xianshi"] forState:UIControlStateSelected];
        _eyeBtn.selected = YES;
        [_eyeBtn addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyeBtn;
}

- (void)eyeAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
//    if (!sender.selected) {
//        self.moneyLb.text = @"***.**";
//        self.todayLb.text = @"***.**";
//    }else {
//        self.moneyLb.text = @"999.99";
//        self.todayLb.text = @"今日 +120.36";
//    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDDENDATA" object:@{@"isOpen":@(sender.selected)}];
}

- (UILabel *)USDTLB {
    
    if (!_USDTLB) {
        _USDTLB = [[UILabel alloc]init];
        _USDTLB.font = [UIFont systemFontOfSize:10];
        _USDTLB.textColor = UIColorFromHEX(0xF5F5F5, 1);
        _USDTLB.text = @"· USDT 80%";
    }
    return _USDTLB;
}

- (UILabel *)EOSLB {
    
    if (!_EOSLB) {
        _EOSLB = [[UILabel alloc]init];
        _EOSLB.font = [UIFont systemFontOfSize:10];
        _EOSLB.textColor = UIColorFromHEX(0xF5F5F5, 1);
        _EOSLB.text = @"· EOS 3%";
    }
    return _EOSLB;
}



@end
