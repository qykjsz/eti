//
//  ETTotalModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTotalModel.h"

@implementation ETTotalModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[TotalData class]};
}

@end

@implementation TotalData

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"assets":[assetsData class]};
}

@end

@implementation glodsData



@end

@implementation assetsData

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"glods":[glodsData class]};
}

@end
