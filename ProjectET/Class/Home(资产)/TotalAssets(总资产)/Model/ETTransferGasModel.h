//
//  ETTransferGasModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TransferGasData;
NS_ASSUME_NONNULL_BEGIN

@interface ETTransferGasModel : NSObject

@property (nonatomic,strong) NSMutableArray <TransferGasData *> *data;

@end

@interface TransferGasData : NSObject

@property (nonatomic,strong) NSString *gasmax;

@property (nonatomic,strong) NSString *gasmin;

@property (nonatomic,strong) NSString *gweimax;

@property (nonatomic,strong) NSString *gweimin;

@property (nonatomic,strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
