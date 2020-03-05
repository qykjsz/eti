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
#import <RongIMKit/RongIMKit.h>

#import "IQKeyboardManager.h"//键盘管理
#import "CTRongManager.h"
#import "ETHTMLViewController.h"
#import "ETAdvertisingH5ViewController.h"
@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMConnectionStatusDelegate,RCIMReceiveMessageDelegate>

@property (nonatomic, strong) UIView *backWhiteView;

@property (nonatomic, strong) NSString *advertisingUrl;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.1234
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
   [self registerRCIM];
   [self JANALYTICSLaunchConfig];
    //网络配置
       [HTTPTool getDomain];
       [self svpSetting];
    [self ET_VCSetting];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [self startuUp];
    
    NSMutableArray *walletArr = WALLET_ARR;
    if (walletArr.count != 0) {
        ETRootViewController *rootVC = [[ETRootViewController alloc]init];
        self.window.rootViewController = rootVC;
    }else {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[ETCoinMainViewController alloc]init]];
        self.window.rootViewController = nav;
    }
    
    
    
   
    
    
    //    [self kmp_VCWillDisappear];
    // 启动动画
//        [self updateApp];
//    [self imageGif:^{
//
//    }];
    
    
    
    return YES;
}

- (void)imageGif:(void(^)(void))complicate {
    
    //    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"ET_New" withExtension:@"gif"]; //加载GIF图片
    //    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL);           //将GIF图片转换成对应的图片源
    //    size_t frameCout = CGImageSourceGetCount(gifSource);                                         //获取其中图片源个数，即由多少帧图片组成
    //    NSMutableArray *frames = [[NSMutableArray alloc] init];                                      //定义数组存储拆分出来的图片
    //    for (size_t i = 0; i < frameCout; i++) {
    //        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL); //从GIF图片中取出源图片
    //        UIImage *imageName = [UIImage imageWithCGImage:imageRef];                  //将图片源转换成UIimageView能使用的图片源
    //        [frames addObject:imageName];                                              //将图片加入数组中
    //        CGImageRelease(imageRef);
    //    }
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    gifImageView.image = [UIImage imageNamed:@"et_qdy"];
    gifImageView.contentMode = UIViewContentModeScaleAspectFill;
    gifImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gifImageViewAction)];
//    [gifImageView addGestureRecognizer:tap];
    //    gifImageView.animationImages = frames; //将图片数组加入UIImageView动画数组中
    //    gifImageView.animationDuration = 3; //每次动画时长
    //    gifImageView.animationRepeatCount = 1;
    //    [gifImageView startAnimating];         //开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
    self.backWhiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backWhiteView.backgroundColor = [UIColor whiteColor];
    [self.backWhiteView addSubview:gifImageView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backWhiteView];
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(SCREEN_WIDTH - 65, 20, 50, 30);
//    btn.layer.cornerRadius = 15.0;
//    btn.layer.masksToBounds = YES;
//    btn.layer.borderWidth = 1;
//    btn.layer.borderColor = [UIColor whiteColor].CGColor;
//    [btn setTitle:@"跳过" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [btn addTarget:self action:@selector(cilkAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.backWhiteView addSubview:btn];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateApp];
        [self cilkAction];
        //        complicate()
    });
}

- (void)cilkAction{
    [self.backWhiteView removeFromSuperview];
    
}

- (void)gifImageViewAction{
    if (![self.advertisingUrl isEqualToString:@""]) {
          ETAdvertisingH5ViewController *vc = [[ETAdvertisingH5ViewController alloc]init];
          vc.url = self.advertisingUrl;
          vc.modalPresentationStyle = UIModalPresentationFullScreen;
          [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    }

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


- (void)startuUp{
//    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"start_up" parameters:@{@"":@""}    type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.advertisingUrl = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"url"]];
            UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [gifImageView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]]]];
               gifImageView.contentMode = UIViewContentModeScaleAspectFill;
               gifImageView.userInteractionEnabled = YES;
               UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gifImageViewAction)];
               [gifImageView addGestureRecognizer:tap];
               //    gifImageView.animationImages = frames; //将图片数组加入UIImageView动画数组中
               //    gifImageView.animationDuration = 3; //每次动画时长
               //    gifImageView.animationRepeatCount = 1;
               //    [gifImageView startAnimating];         //开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
               self.backWhiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
               self.backWhiteView.backgroundColor = [UIColor whiteColor];
               [self.backWhiteView addSubview:gifImageView];
               [[UIApplication sharedApplication].keyWindow addSubview:self.backWhiteView];
               
               UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
               btn.frame = CGRectMake(SCREEN_WIDTH - 65, 20, 50, 30);
               btn.layer.cornerRadius = 15.0;
               btn.layer.masksToBounds = YES;
               btn.layer.borderWidth = 1;
               btn.layer.borderColor = [UIColor whiteColor].CGColor;
               [btn setTitle:@"跳过" forState:UIControlStateNormal];
               btn.titleLabel.font = [UIFont systemFontOfSize:14];
               [btn addTarget:self action:@selector(cilkAction) forControlEvents:UIControlEventTouchUpInside];
               [self.backWhiteView addSubview:btn];
               
               
               
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self updateApp];
                   [self cilkAction];
                   //        complicate()
               });
        }else {
            self.advertisingUrl = @"";
            UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
               gifImageView.image = [UIImage imageNamed:@"et_qdy"];
               gifImageView.contentMode = UIViewContentModeScaleAspectFill;
               gifImageView.userInteractionEnabled = YES;
//               UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gifImageViewAction)];
//               [gifImageView addGestureRecognizer:tap];
               //    gifImageView.animationImages = frames; //将图片数组加入UIImageView动画数组中
               //    gifImageView.animationDuration = 3; //每次动画时长
               //    gifImageView.animationRepeatCount = 1;
               //    [gifImageView startAnimating];         //开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
               self.backWhiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
               self.backWhiteView.backgroundColor = [UIColor whiteColor];
               [self.backWhiteView addSubview:gifImageView];
               [[UIApplication sharedApplication].keyWindow addSubview:self.backWhiteView];
//
//               UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//               btn.frame = CGRectMake(SCREEN_WIDTH - 65, 20, 50, 30);
//               btn.layer.cornerRadius = 15.0;
//               btn.layer.masksToBounds = YES;
//               btn.layer.borderWidth = 1;
//               btn.layer.borderColor = [UIColor whiteColor].CGColor;
//               [btn setTitle:@"跳过" forState:UIControlStateNormal];
//               btn.titleLabel.font = [UIFont systemFontOfSize:14];
//               [btn addTarget:self action:@selector(cilkAction) forControlEvents:UIControlEventTouchUpInside];
//               [self.backWhiteView addSubview:btn];
//
//
//
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self updateApp];
                   [self cilkAction];
                   //        complicate()
               });
        }
       
//        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
    }];
}

- (void)JANALYTICSLaunchConfig{
    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    config.appKey = @"efd63d226e15e5392bf0b03b";
    config.channel = @"iOS";
    [JANALYTICSService crashLogON];
    
    [JANALYTICSService setupWithConfig:config];
}


- (void)registerRCIM{
    // 融云
    [[RCIM sharedRCIM] initWithAppKey:@"y745wfm8yh1dv"];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [RCIM sharedRCIM].connectionStatusDelegate = self;
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
//    //设置用户信息源和群组信息源（这个需要自己实现，写成单例就可以，下面补充）
//      [RCIM sharedRCIM].userInfoDataSource = HYNRCDData;
//      [RCIM sharedRCIM].groupInfoDataSource = HYNRCDData;
    
    [RCIM sharedRCIM].groupInfoDataSource = HYNRCDData;
    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_RECTANGLE;
    [RCIM sharedRCIM].globalMessageAvatarStyle =RC_USER_AVATAR_RECTANGLE;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    [[RCIM sharedRCIM] setEnableMessageAttachUserInfo:YES];
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].globalNavigationBarTintColor = UIColorFromHEX(0x333333, 1);
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    
}


- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_Connected) {
          NSLog(@"融云服务器连接成功!");
      } else  {
          if (status == ConnectionStatus_SignUp) {
              NSLog(@"融云服务器断开连接!");
          } else {
              NSLog(@"融云服务器连接失败!");
          }
      }
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
