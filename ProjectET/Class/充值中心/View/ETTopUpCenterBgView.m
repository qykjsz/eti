//
//  ETTopUpCenterBgView.m
//  ProjectET
//
//  Created by mac on 2019/12/9.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTopUpCenterBgView.h"

@implementation ETTopUpCenterBgView

- (instancetype)initWithCoder:(NSCoder *)coder{
    if ([super initWithCoder:coder]) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6;
        self.layer.borderColor = UIColorFromHEX(0xD6D6D6, 1).CGColor;
        self.layer.borderWidth = 0.5;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
