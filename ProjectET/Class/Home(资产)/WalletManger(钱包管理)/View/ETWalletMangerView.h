//
//  ETWalletMangerView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/8.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ETWalletMangerViewDelegate <NSObject>

- (void)ETWalletMangerViewDelegateAddWallet;

- (void)ETWalletMangerViewDelegateDidSelect:(NSIndexPath *)path model:(ETWalletModel *)model;

@end

@interface ETWalletMangerView : UIView

@property (nonatomic,weak) id <ETWalletMangerViewDelegate> delegate;

- (void)reloadData;

@end
