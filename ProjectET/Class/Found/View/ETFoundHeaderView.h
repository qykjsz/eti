//
//  ETFoundHeaderView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJBannerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETFoundHeaderView : UIView

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) KJBannerView *bannerView;

@end

NS_ASSUME_NONNULL_END
