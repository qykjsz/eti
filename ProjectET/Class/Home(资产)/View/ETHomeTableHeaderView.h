//
//  ETHomeTableHeaderView.h
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTableHeaderSelectView.h"
#import "ETNoticeScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ETHomeTableHeaderViewDelegate <NSObject>

- (void)ETHomeTableHeaderViewDelegateClickAction;

- (void)ETHomeTableHeaderViewDelegateMoreClickAction;

@end

@interface ETHomeTableHeaderView : UIView

@property (nonatomic,strong) UILabel *tipsLb;

@property (nonatomic,strong) UILabel *moneyLb;

@property (nonatomic,strong) UIButton *eyeBtn;

@property (nonatomic,strong) UILabel *todayLb;

@property (nonatomic,strong) UILabel *ETLB;

@property (nonatomic,strong) UILabel *ETHLB;

@property (nonatomic,strong) UILabel *USDTLB;

@property (nonatomic,strong) UILabel *EOSLB;

- (instancetype)initWithFrame:(CGRect)frame andProgress:(NSMutableArray *)progress;

@property (nonatomic,weak) id <ETHomeTableHeaderViewDelegate> delegate;

@property (nonatomic,strong) NSArray *contentArr;

@property (nonatomic,strong) ETNoticeScrollView *scrollView;

@property (nonatomic,strong) ETTableHeaderSelectView *selectView;
@end

NS_ASSUME_NONNULL_END
