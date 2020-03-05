//
//  ETGroupMembersModel.h
//  ProjectET
//
//  Created by mac on 2020/1/2.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETGroupMembersDataModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETGroupMembersModel : NSObject
@property (nonatomic,strong) NSMutableArray <ETGroupMembersDataModel *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETGroupMembersDataModel : NSObject
@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *photo;

@property (nonatomic,strong) NSString *shenfen;

@end

NS_ASSUME_NONNULL_END
