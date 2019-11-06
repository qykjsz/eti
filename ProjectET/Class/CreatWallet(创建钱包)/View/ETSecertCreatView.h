//
//  ETSecertCreatView.h
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETSecertCreatViewDelegate <NSObject>

- (void)ETSecertCreatViewDelegateGyaoClick:(NSString *)Gyao andSyao:(NSString *)Syao;

@end

@interface ETSecertCreatView : UIView

@property (nonatomic,weak) id <ETSecertCreatViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
