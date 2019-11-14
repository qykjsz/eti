//
//  ETAboutUsModel.h
//  ProjectET
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETAboutUsDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface ETAboutUsModel : NSObject
@property (nonatomic,strong) NSMutableArray <ETAboutUsDataModel *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;
@end

@interface ETAboutUsDataModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *iosurl;

@end

NS_ASSUME_NONNULL_END
