//
//  ETPlatformGlodModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/9.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETPlatformGlodData;
NS_ASSUME_NONNULL_BEGIN

@interface ETPlatformGlodModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETPlatformGlodData *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETPlatformGlodData : NSObject

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *hyaddress;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *have;

@end

NS_ASSUME_NONNULL_END
