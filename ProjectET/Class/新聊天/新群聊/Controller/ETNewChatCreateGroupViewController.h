//
//  ETNewChatCreateGroupViewController.h
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETNewChatCreateGroupViewController : UIViewController

///0创建 1加群员 2移除
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) NSString *tid;

@end

NS_ASSUME_NONNULL_END
