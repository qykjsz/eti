//
//  CTRongManager.m
//  ProjectET
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "CTRongManager.h"
#import "ETNewChatMineGroupModel.h"

static CTRongManager *_dataSource = nil;

@implementation CTRongManager


+ (CTRongManager *)shareManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        _dataSource = [[[self class] alloc] init];
    });
    
    return _dataSource;
}

#pragma mark - RCIMGroupInfoDataSource
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion{
    
    [HTTPTool requestDotNetWithURLString:@"rongyun_group" parameters:@{@"qid":groupId} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
                    RCGroup *group = [[RCGroup alloc]init];
                    group.groupId = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"id"]];
                    group.groupName = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
                    group.portraitUri = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]];
                return completion(group);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}

- (void)refrechCircleGroup:(NSString*)groupId{
    [HTTPTool requestDotNetWithURLString:@"rongyun_group" parameters:@{@"qid":groupId} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
                    RCGroup *group = [[RCGroup alloc]init];
                    group.groupId = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"id"]];
                    group.groupName = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
                    group.portraitUri = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]];
            [[RCIM sharedRCIM] refreshGroupInfoCache:group withGroupId:groupId];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}


#pragma mark - RCIMGroupUserInfoDataSource

/**
 *  获取群组内的用户信息。
 *  如果群组内没有设置用户信息，请注意：1，不要调用别的接口返回全局用户信息，直接回调给我们nil就行，SDK会自己巧用用户信息提供者；2一定要调用completion(nil)，这样SDK才能继续往下操作。
 *
 *  @param groupId  群组ID.
 *  @param completion 获取完成调用的BLOCK.
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                      inGroup:(NSString *)groupId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    //在这里查询该group内的群名片信息，如果能查到，调用completion返回。如果查询不到也一定要调用completion(nil)
    //
    //    //数据库取
    //    NSArray * members = [[CTDataBaseManager shareInstance] getGroupMember:groupId];
    //
    //    if (members.count > 0) {
    //        for (RCUserInfo * user in members) {
    //            if ([user.userId isEqualToString:userId]) {
    //                completion(user);
    //            }
    //        }
    //    }else{
    //        //没取到 请求  获取 任何人都行
    //       [CTRongCloudHandle getUserinforWithUserId:userId success:^(CTRongUserModel * userModel) {
    //            RCUserInfo * user = [[RCUserInfo alloc]initWithUserId:userModel.friendUserId name:userModel.friendNickName portrait:userModel.avatarUrl];
    //            completion(user);
    //        } failed:^(id obj) {
    //            completion(nil);
    //        }];
    //
    //    }
    //
    
}


- (void)getAllMembersOfGroup:(NSString *)groupId result:(void (^)(NSArray<NSString *> *userIdList))resultBlock{
    //
    //    NSArray * members = [[CTDataBaseManager shareInstance] getGroupMember:groupId];
    //
    //    if (members.count > 0) {
    //
    //        NSMutableArray *ret = [[NSMutableArray alloc] init];
    //        for (RCUserInfo *user in members) {
    //            [ret addObject:user.userId];
    //        }
    //        resultBlock(ret);
    //
    //    }else{
    //        [CTRongCloudHandle getGroupMembersWithgroupId:groupId success:^(NSArray * obj) {
    //            NSMutableArray *ret = [[NSMutableArray alloc] init];
    //            for (RCUserInfo *user in obj) {
    //                [ret addObject:user.userId];
    //            }
    //            resultBlock(ret);
    //        } failed:^(id obj) {
    //
    //        }];
    //    }
    //
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    
}

@end
