//
//  ETSocketHelper.h
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SocketIO;

NS_ASSUME_NONNULL_BEGIN

@interface ETSocketHelper : NSObject


@property (strong, nonatomic) SocketManager* manager;
@property (strong, nonatomic) SocketIOClient *socket;

#pragma mark - 单例
+ (ETSocketHelper *)sharedSocketHelper;

- (void)socketRequest:(NSString *)urlString AndKey:(NSString *)keyString success:(void (^)(id responseObject))success
failure:(void (^)(NSError * error))failure;
@end

NS_ASSUME_NONNULL_END
