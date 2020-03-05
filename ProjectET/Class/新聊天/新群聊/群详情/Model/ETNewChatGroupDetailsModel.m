//
//  ETNewChatGroupDetailsModel.m
//  ProjectET
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatGroupDetailsModel.h"

@implementation ETNewChatGroupDetailsModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETNewChatGroupDetailsDataModel class]};
}

@end


@implementation ETNewChatGroupDetailsDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}


@end
