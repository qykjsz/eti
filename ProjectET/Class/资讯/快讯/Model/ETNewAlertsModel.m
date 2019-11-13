//
//  ETNewAlertsModel.m
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewAlertsModel.h"

@implementation ETNewAlertsModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETNewConAlertsData class]};
}
@end

@implementation ETNewConAlertsData

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"News":[ETNewConalertNewsListData class]};
}


@end

@implementation ETNewConalertNewsListData



@end
