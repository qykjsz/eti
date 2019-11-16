//
//  ETFoundSectionView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundSectionView.h"

@implementation ETFoundSectionView
- (IBAction)clickAtion:(id)sender {
    
    if (self.foundWebViewblock) {
        self.foundWebViewblock(self.bottomLb.text);
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
