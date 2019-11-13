//
//  ETAlertsModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETConAlertsModel.h"

@implementation ETConAlertsModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[alertsData class]};
}

@end

@implementation alertsData

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"News":[ETalertNewsListData class]};
}


@end

@implementation ETalertNewsListData



@end
