//
//  ETNewChatNewFriendModel.m
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatNewFriendModel.h"

@implementation ETNewChatNewFriendModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETNewChatNewFriendDataModel class]};
}

@end


@implementation ETNewChatNewFriendDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end
