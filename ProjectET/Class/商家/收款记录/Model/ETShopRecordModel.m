//
//  ETShopRecordModel.m
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETShopRecordModel.h"

@implementation ETShopRecordModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETShopRecordDataModel class]};
}
@end


@implementation ETShopRecordDataModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"order":[ETShopRecordOrderModel class]};
}


@end

@implementation ETShopRecordOrderModel



@end
