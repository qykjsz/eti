//
//  ETRootViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/28.
//  Copyright © 2019 LightCould. All rights reserved.
//
#import "ETNewFoundController.h"
#import "ETRootViewController.h"
#import "ETAssetsViewController.h"
#import "MineViewController.h"
#import "FoundViewController.h"
#import "ETChatViewcontroller.h"
#import "ETNewInformationViewController.h"
#import "ETFoundSegmetnController.h"
@interface ETRootViewController ()<UITabBarControllerDelegate>
{
    NSInteger _currentIndex;
}
@end

@implementation ETRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBar.tintColor = [UIColor whiteColor];
    //禁止底部tabbart透明影响view高度问题
//    self.tabBar.translucent = NO;
//    self.delegate = self;
    
    [self setupViewControllers];
}

#pragma mark -
- (void)setupViewControllers {
    
    // 首页
    ETAssetsViewController *homeVC = [ETAssetsViewController new];
    UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    

    // 资讯
    ETNewInformationViewController * mallVC = [ETNewInformationViewController new];
    UINavigationController * mallNav = [[UINavigationController alloc] initWithRootViewController:mallVC];
    
    // 发现
    ETFoundSegmetnController * medicineVC = [ETFoundSegmetnController new];
    UINavigationController * medicineNav = [[UINavigationController alloc] initWithRootViewController:medicineVC];

    // 聊天
    ETChatViewcontroller *cVc = [ETChatViewcontroller new];
    UINavigationController * cVcNav = [[UINavigationController alloc] initWithRootViewController:cVc];
    
    //我的
    MineViewController * meVC = [MineViewController new];
    UINavigationController * meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    self.viewControllers = @[homeNav, mallNav, medicineNav,cVcNav, meNav];
    
    [self customizeTabBarForController];
    
}

- (void)customizeTabBarForController {
    //选项卡图片
    NSArray *tabBarItemImages = @[@"1", @"2", @"3", @"4", @"5"];
    NSArray *tabBarItemTitles = @[@"资产", @"资讯", @"发现", @"聊天",@"我的"];
    NSInteger index = 0;
    for (UIViewController * vc in self.viewControllers) {
        
        UITabBarItem * item = vc.tabBarItem;
        
        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"sel_%@",[tabBarItemImages objectAtIndex:index]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"no_%@",[tabBarItemImages objectAtIndex:index]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = [tabBarItemTitles objectAtIndex:index];
        [item setTitleTextAttributes:@{
                                       NSFontAttributeName: [UIFont fontWithName:AppFontHelvetica size:13],
                                       NSForegroundColorAttributeName:UIColorFromHEX(0xADADAD, 1),
                                       }
                            forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{
                                       NSFontAttributeName: [UIFont fontWithName:AppFontHelvetica size:13],
                                       NSForegroundColorAttributeName:UIColorFromHEX(0x1758FB, 1),
                                       }
                            forState:UIControlStateSelected];
        index ++;
    }
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    if (tabBarController.selectedIndex == 3) {
//
//    }
//
//    //点击tabBarItem动画
//    if (self.selectedIndex != _currentIndex)[self tabBarButtonClick:[self getTabBarButton]];
//
//
//}
//- (UIControl *)getTabBarButton{
//    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
//
//    /*
//     "<_UITabBarBackgroundView: 0x7fddb21236e0; frame = (0 0; 375 49); autoresize = W; userInteractionEnabled = NO; layer = <CALayer: 0x7fddb21297d0>>",
//     "<UITabBarButton: 0x7fddb23bb500; frame = (2 1; 90 48); opaque = NO; layer = <CALayer: 0x7fddb2130880>>",
//     "<UITabBarButton: 0x7fddb217e1a0; frame = (96 1; 90 48); opaque = NO; layer = <CALayer: 0x7fddb217eec0>>",
//     "<UITabBarButton: 0x7fddb2184700; frame = (190 1; 89 48); opaque = NO; layer = <CALayer: 0x7fddb2184e20>>",
//     "<UITabBarButton: 0x7fddb21893c0; frame = (283 1; 90 48); opaque = NO; layer = <CALayer: 0x7fddb2189b60>>",
//     "<UIImageView: 0x7fddb217ea70; frame = (0 -0.5; 375 0.5); autoresize = W; userInteractionEnabled = NO; layer = <CALayer: 0x7fddb219fa40>>"
//     */
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
//            [tabBarButtons addObject:tabBarButton];
//        }
//    }
//    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
//
//    return tabBarButton;
//}
//- (void)tabBarButtonClick:(UIControl *)tabBarButton
//{
//    /*
//     "<UITabBarSwappableImageView: 0x7fd7ebc52760; frame = (32 5.5; 25 25); opaque = NO; userInteractionEnabled = NO; tintColor = UIDeviceWhiteColorSpace 0.572549 1; layer = <CALayer: 0x7fd7ebc52940>>",
//     "<UITabBarButtonLabel: 0x7fd7ebc4f360; frame = (29.5 35; 30 12); text = '\U8d2d\U7269\U8f66'; opaque = NO; userInteractionEnabled = NO; layer = <_UILabelLayer: 0x7fd7ebc4e090>>" a
//     */
//    for (UIView *imageView in tabBarButton.subviews) {
//        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
//            //需要实现的帧动画,这里根据需求自定义
//            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//            animation.keyPath = @"transform.scale";
//            animation.values = @[@1.0,@1.1,@0.9,@1.0];
//            animation.duration = 0.4;
//            animation.calculationMode = kCAAnimationCubic;
//            //把动画添加上去就OK了
//            [imageView.layer addAnimation:animation forKey:nil];
//        }
//    }
//
//    _currentIndex = self.selectedIndex;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
