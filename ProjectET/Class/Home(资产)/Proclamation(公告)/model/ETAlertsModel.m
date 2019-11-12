//
//  ETAlertsModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETAlertsModel.h"

@implementation ETAlertsModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[alertsData class]};
}

@end

@implementation alertsData

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETalertNewsListData class]};
}


@end

@implementation ETalertNewsListData



@end
