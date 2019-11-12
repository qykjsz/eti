//
//  ConsultHeadView.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ConsultHeadViewDelegate <NSObject>

- (void)ConsultHeadViewDelegateWithClikTag:(NSInteger)tag;

@end
@interface ConsultHeadView : UIView
@property (nonatomic,weak) id <ConsultHeadViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
