//
//  ETNewAlertsModel.h
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETNewConAlertsData,ETNewConalertNewsListData;
NS_ASSUME_NONNULL_BEGIN

@interface ETNewAlertsModel : NSObject

@property (nonatomic,strong) ETNewConAlertsData *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETNewConAlertsData : NSObject

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <ETNewConalertNewsListData *> *News;

@end

@interface ETNewConalertNewsListData : NSObject

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *content;

@property (nonatomic,strong) NSString *time;

@property (nonatomic,strong) NSString *islook;

@end

NS_ASSUME_NONNULL_END
