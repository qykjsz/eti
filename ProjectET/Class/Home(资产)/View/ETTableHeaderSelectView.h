//
//  ETTableHeaderSelectView.h
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETTableHeaderSelectView : UIView

@property (nonatomic,strong) void(^homeSelectTag)(NSInteger tag);

@end

NS_ASSUME_NONNULL_END
