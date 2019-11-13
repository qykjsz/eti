//
//  AlertsModel.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class newsListData;
NS_ASSUME_NONNULL_BEGIN

@interface AlertsModel : NSObject

@property (nonatomic,strong) NSMutableArray <newsListData *> *News;

@property (nonatomic,strong) NSString *pages;
@end

@interface newsListData : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *time;

@end
NS_ASSUME_NONNULL_END
