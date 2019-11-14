//
//  ETNewMarketModel.h
//  ProjectET
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ETNewMarketDatasModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETNewMarketModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETNewMarketDatasModel *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETNewMarketDatasModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *shangmoney;

@property (nonatomic,strong) NSString *xiamoney;

@property (nonatomic,strong) NSString *zd;

@end

NS_ASSUME_NONNULL_END
