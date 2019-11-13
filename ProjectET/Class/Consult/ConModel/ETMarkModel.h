//
//  ETMarkModel.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class markData;
NS_ASSUME_NONNULL_BEGIN

@interface ETMarkModel : NSObject
@property (nonatomic,strong) NSMutableArray <markData *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;
@end

@interface markData : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *shangmoney;

@property (nonatomic,strong) NSString *xiamoney;

@property (nonatomic,strong) NSString *zd;
@end

NS_ASSUME_NONNULL_END
