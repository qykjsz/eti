//
//  ETNewChatMineGroupModel.m
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatMineGroupModel.h"

@implementation ETNewChatMineGroupModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETNewChatMineGroupDataModel class]};
}

@end


@implementation ETNewChatMineGroupDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end
