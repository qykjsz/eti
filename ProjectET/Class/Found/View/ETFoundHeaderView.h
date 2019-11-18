//
//  ETFoundHeaderView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJBannerView.h"
#import "ETFoundDappModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ETFoundHeaderViewDelegate <NSObject>

- (void)ETFoundHeaderViewDelegateCollectionClick:(FoundDapp *)model;

@end

@interface ETFoundHeaderView : UIView

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) KJBannerView *bannerView;

@property (nonatomic,weak) id <ETFoundHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
