//
//  AppDelegate.m
//  ProjectET
//
//  Created by hufeng on 2019/10/28.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPTool+DomainAPI.h"//网络配置
#import "AppDelegate+SVPSetting.h" //Toast设置
#import "ETRootViewController.h"
#import "AppDelegate+ET_VCSetting.h"
#import "ETCoinMainViewController.h"
#import "ETDirectTransferController.h"//转账

#import "IQKeyboardManager.h"//键盘管理

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.1234
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
    
    NSMutableArray *walletArr = WALLET_ARR;
    if (walletArr.count != 0) {
        ETRootViewController *rootVC = [[ETRootViewController alloc]init];
        self.window.rootViewController = rootVC;
    }else {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[ETCoinMainViewController alloc]init]];
        self.window.rootViewController = nav;
    }
    
    //网络配置
    [HTTPTool getDomain];
    [self svpSetting];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    [self ET_VCSetting];
//    [self kmp_VCWillDisappear];
    // 启动动画
    [self imageGif:^{

    }];

    

    return YES;
}

- (void)imageGif:(void(^)(void))complicate {
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"ET_New" withExtension:@"gif"]; //加载GIF图片
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL);           //将GIF图片转换成对应的图片源
    size_t frameCout = CGImageSourceGetCount(gifSource);                                         //获取其中图片源个数，即由多少帧图片组成
    NSMutableArray *frames = [[NSMutableArray alloc] init];                                      //定义数组存储拆分出来的图片
    for (size_t i = 0; i < frameCout; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL); //从GIF图片中取出源图片
        UIImage *imageName = [UIImage imageWithCGImage:imageRef];                  //将图片源转换成UIimageView能使用的图片源
        [frames addObject:imageName];                                              //将图片加入数组中
        CGImageRelease(imageRef);
    }
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, iPhoneBang?(SCREEN_HEIGHT-120):SCREEN_HEIGHT)];
    gifImageView.animationImages = frames; //将图片数组加入UIImageView动画数组中
    gifImageView.animationDuration = 3; //每次动画时长
    gifImageView.animationRepeatCount = 1;
    [gifImageView startAnimating];         //开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
    UIView *backWhiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backWhiteView.backgroundColor = [UIColor whiteColor];
    [backWhiteView addSubview:gifImageView];
    [[UIApplication sharedApplication].keyWindow addSubview:backWhiteView];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [backWhiteView removeFromSuperview];
        [self updateApp];
        complicate();
        
    });
}

- (void)updateApp{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"api_update" parameters:@{@"type":@"ios"}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *version = VersionString;
        if (![responseObject[@"data"][@"name"] isEqual:version]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:responseObject[@"data"][@"remark"] preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:responseObject[@"data"][@"download"]]options:@{} completionHandler:^(BOOL success) {
                    exit(0);
                }];
            }];
            [alertController addAction:okAction];
            [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

// 有外部app通过URL Scheme 的方法打开本应用，就会走本应用的这个方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *test = url.host; // 这就是参数
    NSArray *arr = [test componentsSeparatedByString:@"="];
    NSString *type = arr[2];
    NSString *address = arr[1];
    address = [address substringToIndex: address.length - 5];
    NSLog(@"type = %@,address = %@",type,address);
    
    NSMutableArray *walletArr = WALLET_ARR;
    if (walletArr.count != 0) {
        UITabBarController *tab = (UITabBarController *)_window.rootViewController;
        UINavigationController *nav = tab.viewControllers[tab.selectedIndex];
        ETDirectTransferController *vc = [[ETDirectTransferController alloc] init];
        vc.address = address;
        vc.coinNameString = type;
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
    }else {
        
        [SVProgressHUD showWithStatus:@"请创建钱包"];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
