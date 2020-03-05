//
//  ETNewChatHeaderView.h
//  ProjectET
//
//  Created by mac on 2020/1/11.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETNewChatHeaderViewDelegate <NSObject>

- (void)ETNewChatHeaderViewDelegate:(NSInteger)tag;

@end

@interface ETNewChatHeaderView : UIView


@property (nonatomic,weak) id <ETNewChatHeaderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *img_p;

@end

NS_ASSUME_NONNULL_END
