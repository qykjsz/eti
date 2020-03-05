//
//  ETChatLishModel.m
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETChatLishModel.h"

@implementation ETChatLishModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETChatLishDataModel class]};
}

@end

@implementation ETChatLishDataModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"addfriend":[ETChatLishAddfriendModel class],@"addgroup":[ETChatLishAddgroupModel class],@"chats":[ETChatLishcChatsModel class]};
}

@end

@implementation ETChatLishAddfriendModel



@end

@implementation ETChatLishAddgroupModel



@end

@implementation ETChatLishcChatsModel



@end
