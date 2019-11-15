//
//  ETNodeModel.m
//  ProjectET
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNodeModel.h"

@implementation ETNodeModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETNodeOneDateModel class]};
}

@end

@implementation ETNodeOneDateModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETNodeTwoDateModel class]};
}


@end

@implementation ETNodeTwoDateModel

@end
