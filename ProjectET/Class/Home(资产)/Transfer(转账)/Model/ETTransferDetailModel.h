//
//  ETTransferDetailModel.h
//  ProjectET
//
//  Created by hufeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TransDetailData;
NS_ASSUME_NONNULL_BEGIN

@interface ETTransferDetailModel : NSObject

@property (nonatomic,strong) TransDetailData *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface TransDetailData : NSObject

@property (nonatomic,strong) NSString *address;

@property (nonatomic,strong) NSString *otheraddress;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *amount;

@property (nonatomic,strong) NSString *cost;

@property (nonatomic,strong) NSString *hashString;

@property (nonatomic,strong) NSString *blocknumber;

@property (nonatomic,strong) NSString *gas;

@property (nonatomic,strong) NSString *gasp;

@property (nonatomic,strong) NSString *status;

@property (nonatomic,strong) NSString *time;

@end

NS_ASSUME_NONNULL_END
