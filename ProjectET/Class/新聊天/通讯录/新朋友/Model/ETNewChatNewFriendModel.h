//
//  ETNewChatNewFriendModel.h
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETNewChatNewFriendDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface ETNewChatNewFriendModel : NSObject

@property (nonatomic,strong) NSMutableArray <ETNewChatNewFriendDataModel *> *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETNewChatNewFriendDataModel : NSObject

@property (nonatomic,strong) NSString *ID;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *photo;

@property (nonatomic,strong) NSString *state;

@property (nonatomic,strong) NSString *remarks;

@end

NS_ASSUME_NONNULL_END
