//
//  ETFoundDetailModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/17.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETFoundDetailData;
NS_ASSUME_NONNULL_BEGIN

@interface ETFoundDetailModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETFoundDetailData *> *data;

@end

@interface ETFoundDetailData : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *url;

@property (nonatomic,strong) NSString *text;

@end

NS_ASSUME_NONNULL_END
