//
//  AppDelegate+ET_VCSetting.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "AppDelegate+ET_VCSetting.h"
#import "Aspects.h"
#import "UIViewController+NaviBarButton.h"

@implementation AppDelegate (ET_VCSetting)

- (void)ET_VCSetting {
    
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        
        UIViewController * vc = aspectInfo.instance;
        
        if (vc == nil) {
            return ;
        }
        
        //屏蔽一些系统界面
        if ([aspectInfo.instance isKindOfClass:NSClassFromString(@"UIInputWindowController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIWindow")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UINavigationController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UITabBarController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UINavigationController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UICompatibilityInputViewController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"_UIRemoteInputViewController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingControllerNoTouches")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIApplicationRotationFollowingController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UIAlertController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"_UIAlertControllerTextFieldViewController")] ||
            [aspectInfo.instance isKindOfClass:NSClassFromString(@"UISystemKeyboardDockController")]) {

            return;
        }
        
        if (vc.navigationController.viewControllers.count > 1) {
            [vc addLeftBarButtonWithImage:[UIImage imageNamed:@"fh_icon"] action:@selector(popNavi)];
        }
//        vc.view.backgroundColor = [UIColor whiteColor];
        vc.navigationController.navigationBar.translucent = NO;
//        vc.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        
    } error:NULL];
}

@end
