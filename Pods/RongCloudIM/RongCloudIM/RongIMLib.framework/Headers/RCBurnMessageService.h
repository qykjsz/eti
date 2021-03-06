//
//  RCBurnMessageService.h
//  RongIMLib
//
//  Created by Zhaoqianyu on 2018/5/9.
//  Copyright © 2018年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCMessage.h"
#import "RCIMClient.h"

/**
 消息阅后即焚管理类
 */
@interface RCBurnMessageService : NSObject

/**
 焚烧消息管理类单例
 
 @return 单例
 */
+ (instancetype)sharedService;

/**
 设置IMLib阅后即焚监听器

 @param delegate 阅后即焚监听器
 */
- (void)setRCMessageDestructDelegate: (id<RCMessageDestructDelegate>)delegate;

/**
 将消息加入焚烧倒计时队列
 
 @param message 消息
 */
- (void)addBurnMessage:(RCMessage *)message;

/**
 将多个消息加入焚烧倒计时队列
 
 @param messages 消息数组
 */
- (void)addBurnMessages:(NSArray *)messages;

/**
 从焚烧队列中移除消息

 @param messages 消息数组
 */
- (void)removeBurnMessages:(NSArray *)messages;

/**
 获取正在焚烧消息的剩余时间，如果返回nil代表该消息没有处在焚烧队列中
 
 @param burnMessageUId 消息UId
 @return 消息剩余时间
 */
- (NSNumber *)burnMessageRemainDuration: (NSString *)burnMessageUId;

/**
 检测该消息是否应该添加到焚烧队列中
 
 @param message 消息
 @return 该消息是否焚烧结束被删除，返回NO代表被删除
 */
- (BOOL)beginBurnMessageIfNeed:(RCMessage *)message;

/**
 接收到焚烧回执消息的处理（用于非阅读回执方式焚烧的消息）

 @param message 消息数据模型
 @return 返回YES代表是该类型消息开始处理，返回NO不是该类型消息
 */
- (BOOL)didHoldBurnNoticeMessage:(RCMessage *)message;

@end
