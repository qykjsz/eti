//
//  ETChatLishModel.h
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ETChatLishDataModel,ETChatLishAddfriendModel,ETChatLishAddgroupModel,ETChatLishcChatsModel;
NS_ASSUME_NONNULL_BEGIN

@interface ETChatLishModel : NSObject

@property (nonatomic,strong) ETChatLishDataModel *data;

@property (nonatomic,strong) NSString *msg;

@property (nonatomic,strong) NSString *code;

@end

@interface ETChatLishDataModel : NSObject

@property (nonatomic,strong) ETChatLishAddfriendModel *addfriend;

@property (nonatomic,strong) ETChatLishAddgroupModel *addgroup;

@property (nonatomic,strong) NSMutableArray <ETChatLishcChatsModel *> *chats;

@property (nonatomic,strong) NSString *code;

@property (nonatomic,strong) NSString *introduce;

@end

@interface ETChatLishAddfriendModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *time;
@end

@interface ETChatLishAddgroupModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *time;

@property (nonatomic,strong) NSString *qname;

@end


@interface ETChatLishcChatsModel : NSObject

@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) NSString *fromwho;

@property (nonatomic,strong) NSString *fromwhoname;

@property (nonatomic,strong) NSString *qcode;

@property (nonatomic,strong) NSString *text;

@property (nonatomic,strong) NSString *time;

@property (nonatomic,strong) NSString *phone;

@property (nonatomic,strong) NSString *qname;


@end
NS_ASSUME_NONNULL_END
