//
//  KeyChainStore.h
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStore : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end

NS_ASSUME_NONNULL_END
