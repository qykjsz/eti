//
//  ETAddFriendsPopView.m
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETAddFriendsPopView.h"

@implementation ETAddFriendsPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *contenView = [[NSBundle mainBundle]loadNibNamed:@"ETAddFriendsPopView" owner:self options:nil].lastObject;
        contenView.frame = frame;
        [self addSubview:contenView];
        self.constraint_top.constant = iPhoneBang?kStatusBarHeight:(kStatusBarHeight + 30);
    }
    return self;
}

///0创建群聊 1添加好友 2扫一扫
- (IBAction)actionOfTag:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ETAddFriendsPopViewDelegate:)]) {
            [self.delegate ETAddFriendsPopViewDelegate:sender.tag - 500];
           [self actionOfCancle:[UIButton new]];
        }
}

- (IBAction)actionOfCancle:(UIButton *)sender {
   
    [self removeFromSuperview];
}


- (void)show{
   
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
