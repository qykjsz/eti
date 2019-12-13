//
//  ETContactsTableView.m
//  ProjectET
//
//  Created by mac on 2019/12/3.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETContactsTableView.h"

@implementation ETContactsTableView


#define k_ash_action_img [@"__action" hash]

- (void)layoutSubviews {
   [super layoutSubviews];
   
   if (@available(iOS 11.0, *)) {
       if (self.editing)
       for (UIView *swipeActionPullView in self.subviews)
       {
           if([swipeActionPullView isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]){
               for (UIView *swipeActionStandardButton in swipeActionPullView.subviews) {
                   if ([swipeActionStandardButton isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
                       
                       for (UIImageView *imageView in swipeActionStandardButton.subviews) {
                           if ([imageView isKindOfClass:[UIImageView class]]) {
                               if ([imageView viewWithTag:k_ash_action_img]==nil) {
                                   UIImageView *addedImageView = [[UIImageView alloc] initWithFrame:imageView.bounds];
                                   addedImageView.tag = k_ash_action_img;
                                   addedImageView.image= [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                                   [imageView addSubview:addedImageView];
                               }
                               break;
                           }
                       }
                   }
               }
           }
       }
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
