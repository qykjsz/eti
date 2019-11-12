//
//  MineHeadView.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MineHeadViewDelegate <NSObject>

- (void)MineHeadViewDelegateWithClikTag:(NSInteger)tag;

@end

@interface MineHeadView : UIView
@property (nonatomic,weak) id <MineHeadViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
