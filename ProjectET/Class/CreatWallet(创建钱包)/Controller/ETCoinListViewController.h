//
//  ETCoinListViewController.h
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^chooseCoin)(NSString *name);

@interface ETCoinListViewController : UIViewController

@property (nonatomic,strong) chooseCoin block;

@property (nonatomic,assign) BOOL isCreatWallet;

@end

NS_ASSUME_NONNULL_END
