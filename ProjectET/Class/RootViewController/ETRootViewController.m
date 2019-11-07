//
//  ETRootViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/28.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETRootViewController.h"
#import "ETAssetsViewController.h"

@interface ETRootViewController ()<UITabBarControllerDelegate>

@end

@implementation ETRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor whiteColor];
    //禁止底部tabbart透明影响view高度问题
    self.tabBar.translucent = NO;
    self.delegate = self;
    
    [self setupViewControllers];
}

#pragma mark -
- (void)setupViewControllers {
    

    ETAssetsViewController *homeVC = [ETAssetsViewController new];
    UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    
    ETAssetsViewController * mallVC = [ETAssetsViewController new];
    UINavigationController * mallNav = [[UINavigationController alloc] initWithRootViewController:mallVC];
    
    
    ETAssetsViewController * medicineVC = [ETAssetsViewController new];
    UINavigationController * medicineNav = [[UINavigationController alloc] initWithRootViewController:medicineVC];
    
    
    ETAssetsViewController * shoppingCartListVc  = [ETAssetsViewController new];
    UINavigationController * shoppingCartListNav = [[UINavigationController alloc] initWithRootViewController:shoppingCartListVc];
    
    ETAssetsViewController * meVC = [ETAssetsViewController new];
    UINavigationController * meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    self.viewControllers = @[homeNav, mallNav, medicineNav, shoppingCartListNav, meNav];
    
    [self customizeTabBarForController];
    
}

- (void)customizeTabBarForController {
    //选项卡图片
    NSArray *tabBarItemImages = @[@"1", @"2", @"3", @"4", @"5"];
    NSArray *tabBarItemTitles = @[@"资产", @"资讯", @"发现", @"聊天", @"我的"];
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
                                       NSForegroundColorAttributeName:UIColorFromHEX(0x1D57FF, 1),
                                       }
                            forState:UIControlStateSelected];
        index ++;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
