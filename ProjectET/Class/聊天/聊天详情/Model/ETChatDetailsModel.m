//
//  ETChatDetailsModel.m
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETChatDetailsModel.h"

@implementation ETChatDetailsModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETChatDetailsDataModel class]};
}

@end

@implementation ETChatDetailsDataModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"chat":[ETChatDetailsChatModel class]};
}

@end

@implementation ETChatDetailsChatModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end
