//
//  ETSocketHelper.m
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETSocketHelper.h"

@implementation ETSocketHelper

static ETSocketHelper * _socketHelper = nil;

+ (ETSocketHelper *)sharedSocketHelper{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!_socketHelper) {
            _socketHelper = [[super allocWithZone:NULL] init];
        }
    });
    return _socketHelper;
}

- (void)socketRequest:(NSString *)urlString AndKey:(NSString *)keyString success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    
    [ETSocketHelper sharedSocketHelper].manager = [[SocketManager alloc] initWithSocketURL:[NSURL URLWithString:urlString] config:@{@"log": @NO, @"forcePolling": @NO,@"doubleEncodeUTF8":@YES}];
     [ETSocketHelper sharedSocketHelper].socket = [ [ETSocketHelper sharedSocketHelper].manager defaultSocket];
     [[ETSocketHelper sharedSocketHelper].manager connectSocket:[ETSocketHelper sharedSocketHelper].socket];
//     [[ETSocketHelper sharedSocketHelper].manager connect];
    
//        监听是否连接上服务器，正确连接走后面的回调
    
        [ [ETSocketHelper sharedSocketHelper].socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
//            success(data[0]);
            NSLog(@"成功aaaaaaaa");
        }];
    
            [ [ETSocketHelper sharedSocketHelper].socket on:keyString callback:^(NSArray* data, SocketAckEmitter* ack) {
                success(data[0]);
            }];
    
    
    [ [ETSocketHelper sharedSocketHelper].socket connect];
}

@end
