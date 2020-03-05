//
//  CTRongManager.h
//  ProjectET
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

NS_ASSUME_NONNULL_BEGIN

#define HYNRCDData [CTRongManager shareManager]

@interface CTRongManager : NSObject <RCIMUserInfoDataSource, RCIMGroupInfoDataSource>

/**
 *  CTRongManager单例对象
 *
 *  @return CTRongManager单例
 */
+(CTRongManager *) shareManager;


///获取获取群信息信息
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion;

///更新群信息
- (void)refrechCircleGroup:(NSString*)groupId;

@end

NS_ASSUME_NONNULL_END
