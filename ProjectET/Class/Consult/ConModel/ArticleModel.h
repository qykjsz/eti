//
//  ArticleModel.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class articleData,articlNewseData;
NS_ASSUME_NONNULL_BEGIN

@interface ArticleModel : NSObject

@property (nonatomic,strong) articleData *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;
@end

@interface articleData : NSObject

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <articlNewseData *> *News;

@end

@interface articlNewseData : NSObject

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *time;

@end

NS_ASSUME_NONNULL_END
