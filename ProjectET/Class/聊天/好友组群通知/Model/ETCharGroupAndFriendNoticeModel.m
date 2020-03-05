//
//  ETCharGroupAndFriendNoticeModel.m
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETCharGroupAndFriendNoticeModel.h"

@implementation ETCharGroupAndFriendNoticeModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETCharGroupAndFriendNoticeDataModel class]};
}

@end

@implementation ETCharGroupAndFriendNoticeDataModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"list":[ETCharGroupAndFriendNoticeListModel class]};
}

@end

@implementation ETCharGroupAndFriendNoticeListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

@end
