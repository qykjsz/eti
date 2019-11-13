//
//  ETNewArticleModel.h
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ETNewArticleDataModel,ETNewArticleDNewModel;
@interface ETNewArticleModel : NSObject

@property (nonatomic,strong) ETNewArticleDataModel *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETNewArticleDataModel : NSObject

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <ETNewArticleDNewModel *> *News;

@end

@interface ETNewArticleDNewModel : NSObject

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *time;


@end

NS_ASSUME_NONNULL_END
