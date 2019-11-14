//
//  ETMineHelpModel.h
//  ProjectET
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETMineHelpDataModel,ETMineHelpContentModel;

NS_ASSUME_NONNULL_BEGIN

@interface ETMineHelpModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETMineHelpDataModel *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETMineHelpDataModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETMineHelpContentModel *> *content;

@property (nonatomic,strong) NSString *name;

@end

@interface ETMineHelpContentModel : NSObject


@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
