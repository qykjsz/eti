
//
//  ETFoundDappModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundDappModel.h"

@implementation ETFoundDappModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":[FoundDapp class]};
}

@end

@implementation FoundDapp

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
    
}

@end
