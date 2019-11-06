//
//  ETVerifyPassWrodView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETVerifyPassWrodViewDelegate <NSObject>

- (void)ETVerifyPassWrodViewDelegateCancel;

- (void)ETVerifyPassWrodViewDelegateComfirm;


@end

@interface ETVerifyPassWrodView : UIView

@property (nonatomic,strong) void (^Success)(void);

@property (nonatomic,weak) id <ETVerifyPassWrodViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
