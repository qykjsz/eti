//
//  UIViewController+NaviBarButton.m
//  KMPharmacy
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import "UIViewController+NaviBarButton.h"

@implementation UIViewController (NaviBarButton)

- (void)popNavi {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//左侧一个图片按钮的情况

- (UIBarButtonItem *)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action

{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,44,44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    
    [firstButton setImage:image forState:UIControlStateNormal];
    
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    firstButton.tag = 10001;
    
//    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0,0 *SCREEN_WIDTH /375.0,0,0)];
    
    
    
    
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    
    
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    return leftBarButtonItem;
}


//右侧一个图片按钮的情况
- (UIBarButtonItem *)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action

{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,44,44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    
    [firstButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    firstButton.imageView.clipsToBounds = NO;
    
    
    
    
    firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    firstButton.tag = 10001;
    
//    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,5 *SCREEN_WIDTH /375.0)];
    
    
    
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    
    
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    return rightBarButtonItem;
}

//右侧为文字item的情况
- (UIBarButtonItem *)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action

{
    
    
    
    UIButton *rightbBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,88,44)];
    
    [rightbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    
    [rightbBarButton setTitleColor:STRING_DARK_COLOR forState:(UIControlStateNormal)];
    
    rightbBarButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [rightbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    rightbBarButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    
//    [rightbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,5 *SCREEN_WIDTH/375.0)];
    
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbBarButton];

    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    return rightBarButtonItem;
}

//左侧为文字item的情况
- (UIBarButtonItem *)addLeftBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action

{
    
    UIButton *leftbBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,44,44)];
    
    [leftbBarButton setTitle:itemTitle forState:(UIControlStateNormal)];
    
    [leftbBarButton setTitleColor:STRING_DARK_COLOR forState:(UIControlStateNormal)];
    
    leftbBarButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [leftbBarButton addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    leftbBarButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    
//    [leftbBarButton setTitleEdgeInsets:UIEdgeInsetsMake(0,5 *SCREEN_WIDTH/375.0,0,0)];
    
    
    
    UIBarButtonItem *leftbBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:leftbBarButton];
    
    self.navigationItem.leftBarButtonItem = leftbBarButtonItem;
    
    return leftbBarButtonItem;
}


//右侧两个图片item的情况
- (UIBarButtonItem *)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction

{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,80,44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(40, 0, 40, 44);
    
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    
    [firstButton addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    
    
    
    firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    firstButton.imageView.clipsToBounds = NO;

//    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,5 *SCREEN_WIDTH/375.0)];
    firstButton.tag = 10001;
    
    
    [view addSubview:firstButton];
    
    
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    secondButton.frame = CGRectMake(0, 0, 40, 44);
    
    [secondButton setImage:secondImage forState:UIControlStateNormal];
    
    [secondButton addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    
    
    
    secondButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    
//    [secondButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,0 *SCREEN_WIDTH/375.0)];
    secondButton.tag = 10002;
    
    
    [view addSubview:secondButton];
    
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    return rightBarButtonItem;
}

//右侧三个图片item的情况
- (UIBarButtonItem *)addRightThreeBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction thirdImage:(UIImage *)thirdImage thirdAction:(SEL)thirdAction

{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,120,44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(80, 0, 40, 44);
    
    [firstButton setImage:firstImage forState:UIControlStateNormal];
    
    [firstButton addTarget:self action:firstAction forControlEvents:UIControlEventTouchUpInside];
    
    
    
    firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    
//    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,5 *SCREEN_WIDTH/375.0)];
    
    
    
    [view addSubview:firstButton];
    
    
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    secondButton.frame = CGRectMake(44, 0, 40, 44);
    
    [secondButton setImage:secondImage forState:UIControlStateNormal];
    
    [secondButton addTarget:self action:secondAction forControlEvents:UIControlEventTouchUpInside];
    
    
    
    secondButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    
//    [secondButton setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,8 *SCREEN_WIDTH/375.0)];
    
    
    
    [view addSubview:secondButton];
    
    
    
    UIButton *thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    thirdButton.frame = CGRectMake(0, 0, 40, 44);
    
    [thirdButton setImage:thirdImage forState:UIControlStateNormal];
    
    [thirdButton addTarget:self action:thirdAction forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [view addSubview:thirdButton];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
 
    return rightBarButtonItem;
}

@end
