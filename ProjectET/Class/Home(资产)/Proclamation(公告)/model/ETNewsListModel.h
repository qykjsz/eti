//
//  ETNewsListModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETNewsListData,ETNewsData;
NS_ASSUME_NONNULL_BEGIN

@interface ETNewsListModel : NSObject

@property (nonatomic,strong) ETNewsListData *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETNewsData : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *time;


@end

@interface ETNewsListData : NSObject

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <ETNewsData *> *News;

@end

NS_ASSUME_NONNULL_END
