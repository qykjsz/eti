//
//  ETBackUpWalletView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETBackUpWalletViewDelegate <NSObject>

- (void)ETBackUpWalletViewDelegateDeletAction:(ETWalletModel *)model;

- (void)ETBackUpWalletViewDelegateBackUpAction:(ETWalletModel *)model;


@end

@interface ETBackUpWalletView : UIView

@property (nonatomic,strong) id <ETBackUpWalletViewDelegate> delegate;

@property (nonatomic,strong) ETWalletModel *model;
@end

NS_ASSUME_NONNULL_END
