//
//  ETNewArticleModel.m
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewArticleModel.h"

@implementation ETNewArticleModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[ETNewArticleDataModel class]};
}
@end

@implementation ETNewArticleDataModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"News":[ETNewArticleDNewModel class]};
}
@end

@implementation ETNewArticleDNewModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end
