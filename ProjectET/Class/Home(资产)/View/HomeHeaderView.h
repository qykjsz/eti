//
//  HomeHeaderView.h
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeHeaderViewDelegate <NSObject>

- (void)HomeHeaderViewDelegateWithClickTag:(NSInteger)tag;

@end

@interface HomeHeaderView : UIView

@property (nonatomic,strong) UIButton *topLeftBtn;

@property (nonatomic,weak) id <HomeHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
