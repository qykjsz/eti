//
//  ETNewChatDelGroupView.m
//  ProjectET
//
//  Created by mac on 2020/1/17.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatDelGroupView.h"

@implementation ETNewChatDelGroupView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *contenView = [[NSBundle mainBundle]loadNibNamed:@"ETNewChatDelGroupView" owner:self options:nil].lastObject;
        contenView.frame = frame;
        [self addSubview:contenView];
    }
    return self;
}
- (IBAction)actionOfSure:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ETNewChatDelGroupViewDelegateSure)]) {
            [self.delegate ETNewChatDelGroupViewDelegateSure];
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
