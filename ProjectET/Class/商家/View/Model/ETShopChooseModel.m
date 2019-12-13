//
//  ETShopChooseModel.m
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETShopChooseModel.h"

@implementation ETShopChooseModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETShopChooseDataModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"numData":@"data"};
}

@end

@implementation ETShopChooseDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end
