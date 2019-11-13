//
//  ETNewsListModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewsListModel.h"

@implementation ETNewsListModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data": [ETNewsListData class]};
    
}

@end

@implementation ETNewsListData

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"News": [ETNewsData class]};
    
}

@end

@implementation ETNewsData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
    
}

@end
