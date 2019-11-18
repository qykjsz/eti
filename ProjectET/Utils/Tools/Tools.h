//
//  Assistant.h
//  XMPP
//
//  Created by KM on 16/3/292016.
//  Copyright © 2016年 skybrim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Tools : NSObject


/**
 *  获取版本号
 *
 *  @return NSString
 */
+ (NSString *)getVersion;



/**
 *  获取url中的参数
 *
 *  @param urlString url
 *
 *  @return 参数字典
 */
+ (NSDictionary *)getParametersWithUrlString:(NSString *)urlString;

/**
 *  倒计时
 *
 *  @param time  倒计时间
 *  @param end   结束动作
 *  @param going 倒计进行中动作
 */
+ (void)countdownWithTime:(int)time
                      End:(void(^)(void))end
                    going:(void(^)(NSString * time))going;

/**
 *  倒计时
 *  融云15分钟倒计时
 *  @param time  倒计时间
 *  @param end   结束动作
 *  @param going 倒计进行中动作
 */
+ (void)countdownWithDoctorTime:(int)time
                            End:(void(^)(void))end
                          going:(void(^)(NSString * time))going
                          timer:(void(^)(dispatch_source_t timer))timer;

/**
 *  替换手机号中间四位数
 *
 *  @param number 手机号
 *
 *  @return 替换后的手机号
 */
+ (NSString *)replacePhoneMiddleWithPhoneNumber:(NSString *)number;

/**
 *  将对象类型转化为jsonDic
 *
 *  @param object 对象
 *
 *  @return jsonDic
 */
+ (NSDictionary *)convertFromObjectWith:(id)object;

/**
 *  去除URL中的特殊符号
 *
 *  @param string url
 *
 *  @return 去除符号后的url
 */
+ (NSString *)URLEncodedString:(NSString *)string;


/**
 去HTML标签

 @param html 原字符串

 @return 去HTML标签的字符串
 */
+ (NSString *)filterHTML:(NSString *)html;

/**
 *  md5加密
 *
 *  @param str 未加密字符串
 *
 *  @return 加密字符串
 */
+ (NSString *)md5String:(NSString *)str;

/**
 *  判断字符串是不是NSNull类
 *
 *  @param string 字符串
 *
 *  @return YES OR NO
 */
+ (BOOL)isNSNullCharacter:(NSString *)string;


/**
 *  跳转设置界面
 *
 *  @param title   标题
 *  @param message 内容
 *  @param failure 失败时执行
 */
+ (void)showSettingWithTitle:(NSString *)title
                     message:(NSString *)message
                     failure:(void (^)(void))failure;

/**
 *  将字典转化为jsonstring
 *
 *  @param object 对象
 *
 *  @return jsonString
 */
+ (NSString *)dataTojsonString:(id)object;

/**
 将json字符串转为字典

 @param jsonString json字符串
 @return json字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 图片人脸识别

 @param sourceImage 原始图片
 @return 人脸居中图片
 */
+ (UIImage *)findFace:(UIImage *)sourceImage;

/**
 获取storyboard

 @return storyboard
 */
+ (UIStoryboard *) getStoryboardInstance;

/**
 *  获取随机颜色
 *
 *
 *  @return color
 */
+ (UIColor *)getRandomColor;


/**
 *  对比时间差
 *
 *
 *  @return NSTimeInterval
 */
+ (NSTimeInterval)pleaseInsertStarTime:(NSString *)starTime andInsertEndTime:(NSString *)endTime;

/**
 *  时间格式的字符串转date
 *
 *
 *  @return NSdate
 */
+ (NSDate *)stringToNSdate:(NSString *)string;

/**
 *  NSdate转时间字符串
 *
 *
 *  @return NSdate
 */
+ (NSString *)dateToString:(NSDate *)date;

/**
 *  时间戳转化为时间字符串
 *
 *
 *  @return NSString
 */
+(NSString *)timestampSwitchTime:(long long)timestamp andFormatter:(NSString *)format;



/**
 去除字符串中的表情
 */
+ (NSString*)disable_EmojiString:(NSString *)text;


/**
 复制功能
 */
+ (void)copyClickWithText:(NSString *)text;

/**
检验字符串是否为空
*/
+ (BOOL)checkStringIsEmpty:(NSString *)string;

@end

