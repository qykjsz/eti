//
//  ETHomeModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETHomeModel.h"

@implementation ETHomeModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[homeData class]};
}

@end

@implementation homeData

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"glod":[glodData class],@"proportion":[proportionData class]};
}


@end


@implementation glodData

@end

@implementation proportionData

@end
