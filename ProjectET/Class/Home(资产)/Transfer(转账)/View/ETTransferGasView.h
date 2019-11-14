//
//  ETTransferGasView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETTransferGasModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETTransferGasView : UIView

@property (nonatomic,strong) NSString *coinName;

@property (nonatomic,strong) TransferGasData *data;

@property (nonatomic,strong) void(^sliderBlcok)(CGFloat gas,CGFloat transfergas,NSString *gaslimit);

@end

NS_ASSUME_NONNULL_END
