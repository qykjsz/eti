//
//  ArticleModel.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ArticleModel class]};
}
@end
@implementation articleData
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"News":[articlNewseData class]};
}
@end
@implementation articlNewseData
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
    

@end


