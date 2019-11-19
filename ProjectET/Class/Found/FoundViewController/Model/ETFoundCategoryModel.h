//
//  ETFoundCategoryModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/18.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoundCategoryData,FoundCategoryApps;
NS_ASSUME_NONNULL_BEGIN

@interface ETFoundCategoryModel : NSObject

@property (nonatomic,strong) NSMutableArray <FoundCategoryData *> *data;

@end

@interface FoundCategoryData : NSObject

@property (nonatomic,strong) NSString *typenameString;

@property (nonatomic,strong) NSMutableArray <FoundCategoryApps *> *apps;

@end

@interface FoundCategoryApps : NSObject

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *text;

@property (nonatomic,strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
