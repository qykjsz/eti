//
//  UIViewController+NaviBarButton.h
//  KMPharmacy
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NaviBarButton)

//pop视图
- (void)popNavi;

//左侧一个图片按钮的情况
- (UIBarButtonItem *)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action;
//右侧一个图片按钮的情况
- (UIBarButtonItem *)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action;
//右侧为文字item的情况
- (UIBarButtonItem *)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action;
//左侧为文字item的情况
- (UIBarButtonItem *)addLeftBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action;
//右侧两个图片item的情况
- (UIBarButtonItem *)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction;
//右侧三个图片item的情况
- (UIBarButtonItem *)addRightThreeBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction thirdImage:(UIImage *)thirdImage thirdAction:(SEL)thirdAction;


@end
