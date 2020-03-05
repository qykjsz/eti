//
//  ETNewChatToolView.h
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETNewChatToolViewDelegate <NSObject>

- (void)ETNewChatToolViewDelegate:(NSInteger)tag;

@end

@interface ETNewChatToolView : UIView


@property (nonatomic,weak) id <ETNewChatToolViewDelegate> delegate;

-(void)show;

- (void)hiddenTool;

@end

NS_ASSUME_NONNULL_END
