//
//  ETAlertsModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class alertsData,ETalertNewsListData;
NS_ASSUME_NONNULL_BEGIN

@interface ETAlertsModel : NSObject

@property (nonatomic,strong) alertsData *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface alertsData : NSObject

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <ETalertNewsListData *> *News;

@end


@interface ETalertNewsListData : NSObject

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *content;

@property (nonatomic,strong) NSString *time;

@end


NS_ASSUME_NONNULL_END
