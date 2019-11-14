//
//  ETMineHelpModel.m
//  ProjectET
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETMineHelpModel.h"

@implementation ETMineHelpModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETMineHelpDataModel class]};
}

@end


@implementation ETMineHelpDataModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"content":[ETMineHelpContentModel class]};
}

@end

@implementation ETMineHelpContentModel

@end
