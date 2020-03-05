//
//  ETNewChatDelGroupView.h
//  ProjectET
//
//  Created by mac on 2020/1/17.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETNewChatDelGroupViewDelegate <NSObject>

- (void)ETNewChatDelGroupViewDelegateSure;

@end

@interface ETNewChatDelGroupView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (nonatomic,weak) id <ETNewChatDelGroupViewDelegate> delegate;

- (void)show;

@end

NS_ASSUME_NONNULL_END
