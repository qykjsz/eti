//
//  ETHomeModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class homeData,glodData;
NS_ASSUME_NONNULL_BEGIN

@interface ETHomeModel : NSObject

@property (nonatomic,copy) NSString *message;

@property (nonatomic,assign) NSInteger code;

@property (nonatomic,strong) homeData *data;

@property (nonatomic,strong) NSString *msg;


@end

@interface homeData : NSObject

@property (nonatomic,strong) NSString *allnumber;

@property (nonatomic,strong) NSMutableArray <glodData *> *glod;


@end

@interface glodData : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *number;

@property (nonatomic,strong) NSString *proportion;

@property (nonatomic,strong) NSString *usdtnumber;

@end
NS_ASSUME_NONNULL_END
