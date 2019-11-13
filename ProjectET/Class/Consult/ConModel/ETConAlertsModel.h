//
//  ETAlertsModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class conAlertsData,ETConalertNewsListData;
NS_ASSUME_NONNULL_BEGIN

@interface ETConAlertsModel : NSObject

@property (nonatomic,strong) conAlertsData *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface conAlertsData : NSObject

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <ETConalertNewsListData *> *News;

@end


@interface ETConalertNewsListData : NSObject

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *content;

@property (nonatomic,strong) NSString *time;

@end


NS_ASSUME_NONNULL_END
