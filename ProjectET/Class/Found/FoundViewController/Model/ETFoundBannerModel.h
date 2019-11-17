//
//  ETFoundBannerModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/15.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoundBannerData;
NS_ASSUME_NONNULL_BEGIN

@interface ETFoundBannerModel : NSObject

@property (nonatomic,strong) NSMutableArray <FoundBannerData *> *data;

@end

@interface FoundBannerData : NSObject

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *url;


@end

NS_ASSUME_NONNULL_END
