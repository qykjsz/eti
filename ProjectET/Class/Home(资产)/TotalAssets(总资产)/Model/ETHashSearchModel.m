//
//  ETHashSearchModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETHashSearchModel.h"

@implementation ETHashSearchModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[hashData class]};
}

@end

@implementation hashData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id",@"hashString":@"hash"};
}

@end
