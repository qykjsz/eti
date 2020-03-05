//
//  ETGroupMembersModel.m
//  ProjectET
//
//  Created by mac on 2020/1/2.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETGroupMembersModel.h"

@implementation ETGroupMembersModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETGroupMembersDataModel class]};
}
@end

@implementation ETGroupMembersDataModel


@end
