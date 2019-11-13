//
//  ETHomeModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class homeData,glodData,proportionData,newsData;
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

@property (nonatomic,strong) NSMutableArray <newsData *> *news;

@property (nonatomic,strong) NSMutableArray <proportionData *> *proportion;

@property (nonatomic,strong) NSString *today;


@end

@interface proportionData : NSObject

@property (nonatomic,strong) NSString *bili;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) UIColor *color;

@end

@interface glodData : NSObject

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *number;

@property (nonatomic,strong) NSString *proportion;

@property (nonatomic,strong) NSString *usdtnumber;

@property (nonatomic,strong) NSString *address;


@end

@interface newsData : NSObject

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *name;


@end
NS_ASSUME_NONNULL_END
