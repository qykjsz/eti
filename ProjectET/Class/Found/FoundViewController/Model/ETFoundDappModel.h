//
//  ETFoundDappModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoundDapp;
NS_ASSUME_NONNULL_BEGIN

@interface ETFoundDappModel : NSObject

@property (nonatomic,strong) NSMutableArray <FoundDapp *> *data;

@end

@interface FoundDapp : NSObject

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *url;

@property (nonatomic,strong) NSString *Id;

@end

NS_ASSUME_NONNULL_END
