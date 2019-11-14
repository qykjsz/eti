//
//  ETTotalModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TotalData,glodsData,assetsData;
NS_ASSUME_NONNULL_BEGIN

@interface ETTotalModel : NSObject

@property (nonatomic,strong) TotalData *data;

@end

@interface TotalData : NSObject

@property (nonatomic,strong) NSString *allnumber;

@property (nonatomic,strong) NSString *today;

@property (nonatomic,strong) NSMutableArray <assetsData *> *assets;

@end

@interface assetsData : NSObject

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *number;

@property (nonatomic,strong) NSString *usdtnumber;

@property (nonatomic,strong) NSMutableArray <glodsData *> *glods;

@end

@interface glodsData : NSObject

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *number;

@property (nonatomic,strong) NSString *usdtnumber;

@end

NS_ASSUME_NONNULL_END
