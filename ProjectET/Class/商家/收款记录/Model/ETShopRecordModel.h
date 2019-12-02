//
//  ETShopRecordModel.h
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETShopRecordDataModel,ETShopRecordOrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETShopRecordModel : NSObject

@property (nonatomic,strong) ETShopRecordDataModel *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETShopRecordDataModel : NSObject

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <ETShopRecordOrderModel *> *order;

@end

@interface ETShopRecordOrderModel : NSObject

@property (nonatomic,strong) NSString *from;

@property (nonatomic,strong) NSString *money;

@property (nonatomic,strong) NSString *moneyname;

@property (nonatomic,strong) NSString *fimoney;

@property (nonatomic,strong) NSString *fimoneyname;

@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) NSString *time;

@property (nonatomic,strong) NSString *color;
@end

NS_ASSUME_NONNULL_END
