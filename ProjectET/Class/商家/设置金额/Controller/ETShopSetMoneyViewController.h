//
//  ETShopSetMoneyViewController.h
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETShopSetMoneyViewControllerDelegate <NSObject>

- (void)ETShopSetMoneyViewControllerDelegateWithCell:(NSString *)jsonStr;

@end

@interface ETShopSetMoneyViewController : UIViewController
@property (nonatomic,weak) id <ETShopSetMoneyViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
