//
//  ETMyWalletView.h
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETMyWalletViewDelegate <NSObject>

- (void)ETMyWalletViewDelegateAddWallet;

- (void)ETMyWalletViewDelegateWalletManger;

@end

@interface ETMyWalletView : UIView

- (void)show;

@property (nonatomic,weak) id <ETMyWalletViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
