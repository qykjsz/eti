//
//  ETAddressBookModel.m
//  ProjectET
//
//  Created by mac on 2020/1/3.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETAddressBookModel.h"

@implementation ETAddressBookModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETAddressBookDataModel class]};
}

@end

@implementation ETAddressBookDataModel


@end
