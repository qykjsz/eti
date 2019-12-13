//
//  ETMycontactListModel.m
//  ProjectET
//
//  Created by hufeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETMycontactListModel.h"

@implementation ETMycontactListModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[contactData class]};
    
}

@end


@implementation contactData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end
