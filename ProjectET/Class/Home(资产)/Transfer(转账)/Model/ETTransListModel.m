//
//  ETTransListModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransListModel.h"

@implementation ETTransListModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[TransListData class]};
    
}

@end

@implementation TransListData

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"order":[orderData class]};
    
}

@end


@implementation orderData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

@end
