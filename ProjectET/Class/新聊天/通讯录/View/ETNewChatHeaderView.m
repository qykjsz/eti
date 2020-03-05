//
//  ETNewChatHeaderView.m
//  ProjectET
//
//  Created by mac on 2020/1/11.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatHeaderView.h"

@implementation ETNewChatHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *contenView = [[NSBundle mainBundle]loadNibNamed:@"ETNewChatHeaderView" owner:self options:nil].lastObject;
        contenView.frame = frame;
        [self addSubview:contenView];
    }
    return self;
}

///0创建群聊 1添加好友 2扫一扫
- (IBAction)actionOfTag:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ETNewChatHeaderViewDelegate:)]) {
             [self.delegate ETNewChatHeaderViewDelegate:sender.tag - 500];
        }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
