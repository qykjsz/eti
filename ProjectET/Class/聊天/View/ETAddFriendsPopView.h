//
//  ETAddFriendsPopView.h
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETAddFriendsPopViewDelegate <NSObject>

- (void)ETAddFriendsPopViewDelegate:(NSInteger)tag;

@end

@interface ETAddFriendsPopView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_top;

@property (nonatomic,weak) id <ETAddFriendsPopViewDelegate> delegate;

-(void)show;
@end

NS_ASSUME_NONNULL_END
