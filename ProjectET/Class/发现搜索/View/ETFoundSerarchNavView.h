//
//  ETFoundSerarchNavView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETFoundSerarchNavViewDelegate <NSObject>

- (void)ETFoundSerarchNavViewCancle;

- (void)ETFoundSerarchNavViewTextfiled:(UITextField *)textfield;

- (void)ETFoundSerarchNavViewReturn:(UITextField *)textfiled;

@end

@interface ETFoundSerarchNavView : UIView

@property (nonatomic,weak) id <ETFoundSerarchNavViewDelegate> delegate;

@property (nonatomic,strong) UITextField *textfiled;

@end

NS_ASSUME_NONNULL_END
