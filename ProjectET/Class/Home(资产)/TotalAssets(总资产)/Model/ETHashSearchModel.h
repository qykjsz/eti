//
//  ETHashSearchModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class hashData;
NS_ASSUME_NONNULL_BEGIN

@interface ETHashSearchModel : NSObject

@property (nonatomic,strong) hashData *data;

@property (nonatomic,strong) NSString *code;

@property (nonatomic,strong) NSString *msg;

@end

@interface hashData : NSObject

@property (nonatomic,strong) NSString *amount;

@property (nonatomic,strong) NSString *hashString;

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *status;

@property (nonatomic,strong) NSString *time;

@property (nonatomic,strong) NSString *type;

@end

NS_ASSUME_NONNULL_END
