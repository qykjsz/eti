//
//  ETTopupCenterRecordModel.m
//  ProjectET
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTopupCenterRecordModel.h"

@implementation ETTopupCenterRecordModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETTopupCenterRecordDataModel class]};
}
@end

@implementation ETTopupCenterRecordDataModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"order":[ETTopupCenterRecordOrderModel class]};
}


@end

@implementation ETTopupCenterRecordOrderModel



@end
