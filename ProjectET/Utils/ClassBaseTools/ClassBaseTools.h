//
//  ClassBaseTools.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/6.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassBaseTools : NSObject
+ (UIView *)viewWithBackgroundColor:(UIColor *)backgroundColor;

+ (UIView *)backView;
+ (UIView *)lineView;
+ (UILabel *)labelWithFont:(CGFloat)font
                 textColor:(UIColor *)textColor
             textAlignment:(NSTextAlignment)textAlignment;

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                                   font:(CGFloat)font
                            titlesColor:(UIColor *)titlesColor
             contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
                                  title:(NSString *)title;

+ (UIButton *)buttonWithFont:(CGFloat)font
                 titlesColor:(UIColor *)titlesColor
  contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
                       title:(NSString *)title;

+ (UITextField *)textFieldWithFont:(CGFloat)font
                       titlesColor:(UIColor *)titlesColor
                      keyboardType:(UIKeyboardType)keyboardType
                     returnKeyType:(UIReturnKeyType)returnKeyType
                       placeholder:(NSString *)placeholder
                              text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
