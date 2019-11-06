//
//  ETWalletManger.h
//  ProjectET
//
//  Created by hufeng on 2019/11/4.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETWalletModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETWalletManger : NSObject

+ (ETWalletModel *)getCurrentWallet;

+ (ETWalletModel *)getModelIndex:(NSInteger)index;

+ (void)updateWallet:(ETWalletModel *)model;

+ (void)deleWallet:(ETWalletModel *)model;

+ (void)addWallet:(ETWalletModel *)model;

@end

NS_ASSUME_NONNULL_END
