//
//  ETFoundCategoryModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/18.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundCategoryModel.h"

@implementation ETFoundCategoryModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[FoundCategoryData class]};
}

@end

@implementation FoundCategoryData

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"apps":[FoundCategoryApps class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"typenameString":@"typename"};
}


@end

@implementation FoundCategoryApps

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

@end
