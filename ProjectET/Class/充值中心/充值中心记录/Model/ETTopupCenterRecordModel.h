//
//  ETTopupCenterRecordModel.h
//  ProjectET
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETTopupCenterRecordDataModel,ETTopupCenterRecordOrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETTopupCenterRecordModel : NSObject
@property (nonatomic,strong) ETTopupCenterRecordDataModel *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETTopupCenterRecordDataModel : NSObject

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <ETTopupCenterRecordOrderModel *> *order;

@end

@interface ETTopupCenterRecordOrderModel : NSObject

@property (nonatomic,strong) NSString *gamename;

@property (nonatomic,strong) NSString *gameuser;

@property (nonatomic,strong) NSString *gamenumber;

@property (nonatomic,strong) NSString *moneystate;

@property (nonatomic,strong) NSString *money;

@property (nonatomic,strong) NSString *time;

@property (nonatomic,strong) NSString *color;

@property (nonatomic,strong) NSString *state;
@end

NS_ASSUME_NONNULL_END
