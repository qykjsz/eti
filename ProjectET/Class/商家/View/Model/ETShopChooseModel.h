//
//  ETShopChooseModel.h
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETShopChooseDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETShopChooseModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETShopChooseDataModel *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETShopChooseDataModel : NSObject

@property (nonatomic,strong) NSString *ID;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *rate;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *gasprice;

@property (nonatomic,strong) NSString *gaslimit;

@property (nonatomic,strong) NSString *decimal;

@property (nonatomic,strong) NSString *address;
@end

NS_ASSUME_NONNULL_END
