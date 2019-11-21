//
//  AppDelegate+SVPSetting.m
//  ProjectET
//
//  Created by hufeng on 2019/11/8.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "AppDelegate+SVPSetting.h"

@implementation AppDelegate (SVPSetting)

- (void)svpSetting {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    
    //设置提示框的边角弯曲半径
    [SVProgressHUD setCornerRadius:5];
    
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
    [SVProgressHUD dismissWithDelay:1.0];

}


@end
