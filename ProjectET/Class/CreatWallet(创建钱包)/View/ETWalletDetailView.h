//
//  ETWalletDetailView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETWalletDetailView : UIView

@property (nonatomic,strong) UILabel *tipsLb;

@property (nonatomic,strong) UILabel *moneyLb;

@property (nonatomic,strong) UIButton *eyeBtn;

@property (nonatomic,strong) UILabel *todayLb;

@property (nonatomic,strong) UILabel *ETLB;

@property (nonatomic,strong) UILabel *ETHLB;

@property (nonatomic,strong) UILabel *USDTLB;

@property (nonatomic,strong) UILabel *EOSLB;

@property (nonatomic,assign) BOOL isOpen;

- (instancetype)initWithFrame:(CGRect)frame andProgress:(NSMutableArray *)progress;

@end

NS_ASSUME_NONNULL_END
