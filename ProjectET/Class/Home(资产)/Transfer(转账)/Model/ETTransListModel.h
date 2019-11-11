//
//  ETTransListModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TransListData,orderData;
NS_ASSUME_NONNULL_BEGIN

@interface ETTransListModel : NSObject

@property (nonatomic,strong) TransListData *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface TransListData : NSObject

@property (nonatomic,strong) NSString *number;

@property (nonatomic,strong) NSString *usdtnumber;

@property (nonatomic,strong) NSString *today;

@property (nonatomic,strong) NSString *pages;

@property (nonatomic,strong) NSMutableArray <orderData *> *order;



@end

@interface orderData : NSObject

@property (nonatomic,strong) NSString *Id;

@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) NSString *amount;

@property (nonatomic,strong) NSString *status;

@property (nonatomic,strong) NSString *time;

@property (nonatomic,strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
