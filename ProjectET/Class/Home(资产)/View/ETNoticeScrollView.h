//
//  ETNoticeScrollView.h
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETNoticeScrollViewDelegate

@optional
/// 点击代理
- (void)noticeScrollDidClickAtIndex:(NSInteger)index content:(NSString *)content;

@end

@interface ETNoticeScrollView : UIView

@property (nonatomic, weak) id<ETNoticeScrollViewDelegate> delegate;

/// 滚动文字数组
@property (nonatomic, strong) NSArray *contents;

/// 文字停留时长，默认4S
@property (nonatomic, assign) NSTimeInterval timeInterval;

/// 文字滚动时长，默认0.3S
@property (nonatomic, assign) NSTimeInterval scrollTimeInterval;


@end

NS_ASSUME_NONNULL_END
