//
//  KMPMacro.h
//  KMPharmacy
//
//  Created by mac on 2018/5/7.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//
#import <Availability.h>

#ifndef ETMacro_h
#define ETMacro_h

#define APPSTORE_ID @"1395275648"

//微信appid
//#define WeChatAppId @"wxb03581df0d6ba2cf"
#define WeChatAppId @"wx28be79405768f5f1"

//接口加密
#define kmp_userid [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]//userid
#define kmp_usertoken [[NSUserDefaults standardUserDefaults] valueForKey:@"usertoken"]//usertoken
#define kmp_appid @"8145955969"//appid
#define kmp_appsectet @"l8y70yhm8vonwc904i6ugjs3s1zfqo77"//appsectet
#define kmp_appkey @"b37443f8f19f123ebbd01b07615af4cdfdc9a89b1a839f413323703f40e8847d"//appkey


//keychain
#define ServiceName @"com.HealthBAT.KMPharmacy"//保存密码的标示

//颜色
#define BASE_COLOR UIColorFromHEX(0x0ccdd3, 1)//基调色
#define BASE_BACKGROUND_COLOR UIColorFromHEX(0xf5f5f5, 1)//背景灰色
#define STRING_DARK_COLOR UIColorFromHEX(0x333333, 1)//文字灰色
#define STRING_MID_COLOR UIColorFromHEX(0x666666, 1)//文字灰色
#define STRING_LIGHT_COLOR UIColorFromHEX(0x999999, 1)//文字灰色
#define STRING_RED_COLOR UIColorFromHEX(0xff4c56, 1)//文字红色
#define START_COLOR UIColorFromHEX(0x29ccbf, 1)//渐变色
#define END_COLOR UIColorFromHEX(0x6ccc56, 1)//渐变色
#define BASE_LINE_COLOR UIColorFromHEX(0xe0e0e0, 1)//分割线颜色

//缓存图片路径
#define CacheImageFilePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"cacheImage"]

//设置登录状态
#define SET_LOGIN_STATION(bool) [[NSUserDefaults standardUserDefaults] setBool:bool forKey:@"LoginStation"];[[NSUserDefaults standardUserDefaults] synchronize];
//登录状态
#define LOGIN_STATION [[NSUserDefaults standardUserDefaults] boolForKey:@"LoginStation"]

//弹出登录界面
#define PRESENT_LOGIN_VC KMPLoginRegisterViewController *loginRegisterVC = [[KMPLoginRegisterViewController alloc] init]; loginRegisterVC.hidesBottomBarWhenPushed = YES;UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginRegisterVC]; [self.navigationController presentViewController:nav animated:YES completion:nil];

//个人定位坐标系
#define KMP_LONGITUDE [[NSUserDefaults standardUserDefaults] objectForKey:@"longitude"]
#define KMP_LATITUDE [[NSUserDefaults standardUserDefaults] objectForKey:@"latitude"]

//保存在本地的收货地址
#define KMP_ADDRESSDATA [NSKeyedUnarchiver unarchiveObjectWithFile: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AddressData.data"]]
//保存处方单所选的上一次收货地址
#define KMP_PRESADDRESSDATA [NSKeyedUnarchiver unarchiveObjectWithFile: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/PresAddressData.data"]]
//保存在本地的手机当前位置
#define KMP_CURRENT_ADDRESSDATA [NSKeyedUnarchiver unarchiveObjectWithFile: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CurrentAddressData.data"]]

//广告信息
#define ADVERT_INFO [NSKeyedUnarchiver unarchiveObjectWithFile: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AdvertInfo.data"]]

//夜间购药状态
#define NIGHT_SERVICE_STATION [[NSUserDefaults standardUserDefaults] boolForKey:@"NightServiceStation"]


//登录信息
#define LOGIN_INFO [NSKeyedUnarchiver unarchiveObjectWithFile: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UserLoginInfo.data"]]
//个人信息
#define PERSON_INFO [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Person.data"]]
//手机信息
#define PHONE_INFO [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Phone.data"]]
//会员信息
#define MEMBER_INFO [NSKeyedUnarchiver unarchiveObjectWithFile: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MemberInfo.data"]]
//融云用户数据
#define locationRongCloudUserData @"Documents/rongCloudUserData"
#define locationRongCloudAllUserData @"Documents/rongCloudALLUserData"


//钱包信息
#define WALLET_ARR [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/WalletData.data"]]

//全局宏
#define BAT_NO_DATA @"暂时没有数据"
#define BAT_NO_NETWORK @"呜呜呜，断网啦"
#define ErrorText @"网络异常，请稍后再试！"

//字体
#define AppFontHelvetica  @"PingFangSC-Regular"


#endif /* KMPMacro_h */
