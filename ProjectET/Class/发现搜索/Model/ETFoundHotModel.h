//
//  ETFoundHotModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/17.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoundHotData;
NS_ASSUME_NONNULL_BEGIN

@interface ETFoundHotModel : NSObject

@property (nonatomic,strong) NSMutableArray <FoundHotData *> *data;

@end

@interface FoundHotData : NSObject

@property (nonatomic,strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
