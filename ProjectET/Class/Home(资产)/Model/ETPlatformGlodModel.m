//
//  ETPlatformGlodModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/9.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETPlatformGlodModel.h"

@implementation ETPlatformGlodModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[ETPlatformGlodData class]};
}

@end

@implementation ETPlatformGlodData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

@end
