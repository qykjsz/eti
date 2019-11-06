//
//  ETMyWalletIconCell.h
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETMyWalletLeftModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETMyWalletIconCell : UITableViewCell

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UIImageView *coinImage;

@property (nonatomic,strong) ETMyWalletLeftModel *model;

@end

NS_ASSUME_NONNULL_END
