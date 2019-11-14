//
//  ETAboutUsModel.m
//  ProjectET
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETAboutUsModel.h"

@implementation ETAboutUsModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETAboutUsDataModel class]};
}

@end

@implementation ETAboutUsDataModel

@end
