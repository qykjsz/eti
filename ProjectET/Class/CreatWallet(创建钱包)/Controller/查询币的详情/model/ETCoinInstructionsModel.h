//
//  ETCoinInstructionsModel.h
//  ProjectET
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETCoinInstructionsDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETCoinInstructionsModel : NSObject
@property (nonatomic,strong) ETCoinInstructionsDataModel  *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;
@end

@interface ETCoinInstructionsDataModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *img;

@property (nonatomic,strong) NSString *website;

@property (nonatomic,strong) NSString *paper;

@property (nonatomic,strong) NSString *issuetime;

@property (nonatomic,strong) NSString *issuenumber;

@property (nonatomic,strong) NSString *issueprice;

@property (nonatomic,strong) NSString *introduction;

@end

NS_ASSUME_NONNULL_END
