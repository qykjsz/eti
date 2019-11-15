//
//  ETNodeModel.h
//  ProjectET
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETNodeOneDateModel,ETNodeTwoDateModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETNodeModel : NSObject
@property (nonatomic,strong) ETNodeOneDateModel *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;
@end

@interface ETNodeOneDateModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETNodeTwoDateModel *> *data;

@property (nonatomic,strong) NSString *status;

@property (nonatomic,strong) NSString *msg;
@end

@interface ETNodeTwoDateModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *url;

@property (nonatomic,strong) NSString *speed;
@end

NS_ASSUME_NONNULL_END
