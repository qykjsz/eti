//
//  ETNewChatDetailsViewController.h
//  ProjectET
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETNewChatDetailsViewController : RCConversationViewController

@property (nonatomic, strong) NSString *fromGroupType;

@end

NS_ASSUME_NONNULL_END
