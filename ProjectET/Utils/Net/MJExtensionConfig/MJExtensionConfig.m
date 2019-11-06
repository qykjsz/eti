//
//  MJExtensionConfig.m
//  KMPharmacy
//
//  Created by mac on 2018/5/7.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import "MJExtensionConfig.h"

@implementation MJExtensionConfig

+ (void)load
{
    [NSObject mj_setupNewValueFromOldValue:^id(id object, id oldValue, MJProperty *property) {
        
        if (property.type.typeClass == [NSString class]) {
            
            if (oldValue == nil) {
                return @"";
            } else if ([oldValue isKindOfClass:[NSNull class]]) {
                return @"";
            } else if ([oldValue isKindOfClass:[NSString class]]) {
                if ([oldValue isEqualToString:@"(null)"] || [oldValue isEqualToString:@"<null>"] || [oldValue isEqualToString:@"null"] || [oldValue isEqualToString:@"(NULL)"]) {
                    return @"";
                }
            }
        }
        return oldValue;
    }];
}

@end
