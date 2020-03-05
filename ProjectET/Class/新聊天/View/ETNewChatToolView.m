//
//  ETNewChatToolView.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatToolView.h"

@implementation ETNewChatToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *contenView = [[NSBundle mainBundle]loadNibNamed:@"ETNewChatToolView" owner:self options:nil].lastObject;
        contenView.frame = frame;
        [self addSubview:contenView];
    }
    return self;
}


///0创建群聊 1添加好友 2扫一扫
- (IBAction)actionOfTag:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ETNewChatToolViewDelegate:)]) {
            [self.delegate ETNewChatToolViewDelegate:sender.tag - 500];
           [self actionOfCancle:[UIButton new]];
        }
}


- (IBAction)actionOfCancle:(UIButton *)sender {
   
    [self removeFromSuperview];
}


- (void)show{
   
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hiddenTool {
    [self actionOfCancle:[UIButton new]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
