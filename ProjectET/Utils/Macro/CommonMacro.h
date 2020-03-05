//
//  CommonMacro.h
//  XMPP
//
//  Created by KM on 16/3/28.
//  Copyright © 2016年 skybrim. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

//mainWindow
#define MAIN_WINDOW [UIApplication sharedApplication].keyWindow



//宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//字体
//#define stringFont(s) [UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:s]
#define stringFont(s) [UIFont systemFontOfSize:s]

//颜色
// RGB颜色转换（16进制->10进制）
#define UIColorFromHEX(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]
#define UIColorFromRGB(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#define RGB(a,b,c)      [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]
#define batRandomColor RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#define IS_IOS10 ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 10)
#define IS_IOS9 ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 9)
#define IS_IOS8 ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8)
#define IS_IOS7 ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)
#define IS_IOS6 ([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] == 6)
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//判断IOS版本
#define iPhoneSystemVersion ([UIDevice currentDevice].systemVersion.floatValue)

//定义设备的类型

#define iPad   ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"] isEqualToString:@"iPhone X"]?YES:NO)

#define iPhone4   ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"] isEqualToString:@"iPhone 4"]?YES:NO)
#define iPhone5   ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"] isEqualToString:@"iPhone 5"]?YES:NO)
#define iPhone6   ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"] isEqualToString:@"iPhone 6"]?YES:NO)
#define iPhone6p  ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"] isEqualToString:@"iPhone 6 Plus"]?YES:NO)
#define iPhoneX   ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"] isEqualToString:@"iPhone X"]?YES:NO)
#define iPhoneXR   ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"] isEqualToString:@"iPhone XR"]?YES:NO)
#define iPhoneXSMax   ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceName"] isEqualToString:@"iPhone XS Max"]?YES:NO)
#define iPhoneBang (([UIApplication sharedApplication].statusBarFrame.size.height == 44)?(YES):(NO))

/*状态栏高度*/
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kStatusAndNavHeight (kStatusBarHeight + kNavBarHeight)
/*TabBar高度*/
#define kTabBarHeight (CGFloat)((iPhoneX||iPhoneXSMax||iPhoneXR)?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)((iPhoneX||iPhoneXSMax||iPhoneXR)?(44.0):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)((iPhoneX||iPhoneXSMax||iPhoneXR)?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)((iPhoneX||iPhoneXSMax||iPhoneXR)?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kStatusAndNavHeight + kTabBarHeight)


//设备系统
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))
#define IOS_VERSION_9_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)? (YES):(NO))
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)? (YES):(NO))
#define IOS_VERSION_11_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)? (YES):(NO))

//根据屏幕比例来获取宽高和Size
#define Width(x) (float)x * SCREEN_WIDTH / 375.0f
#define Height(x) (float)x * SCREEN_WIDTH / 375.0f
#define Size(x,y) CGSizeMake(Width(x),Height(y))

/*版本号*/
#define VersionString [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define BuildString [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define kVersion @"1.0.1"

//适配adjustsScrollViewInsets属性

#define  adjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)

#ifdef RELEASE
#define NSLog(...)
#define debugMethod()
#else
#define NSLog(format, ...) NSLog((@"\n[函数名:%s]" "[行号:%d]  \n" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define debugMethod() NSLog(@"%s", __func__)
#endif

#endif /* CommonMacro_h */
