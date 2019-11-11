//
//  ETTransferDetailModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransferDetailModel.h"

@implementation ETTransferDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[TransDetailData class]};

}

@end

@implementation TransDetailData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"hashString":@"hash"};
    
}
@end
