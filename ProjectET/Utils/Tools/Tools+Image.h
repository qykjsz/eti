//
//  Tools+Image.h
//  KMPharmacy
//
//  Created by mac on 2018/5/7.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import "Tools.h"

@interface Tools (Image)

/**
 *  改变image的alpha
 *
 *  @param alpha alpha
 *  @param image 原图
 *
 *  @return 改变alpha值的图片
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;


/**
 *  根据颜色值获取image
 *
 *  @param color 指定颜色
 *
 *  @return image
 */
+ (UIImage *)imageFromColor:(UIColor *)color;


/**
 *  图片压缩方法
 *
 *  @param orignalImage 原图
 *  @param percent      缩放压缩质量
 *
 *  @return image
 */
+ (UIImage *)compressImageWithImage:(UIImage *)orignalImage ScalePercent:(CGFloat)percent;

/**
 *  压缩图片质量
 *
 *  @param image   原图
 *  @param percent 压缩质量
 *
 *  @return image
 */
+ (UIImage *)reduceImage:(UIImage *)image percent:(float)percent;

/**
 *  压缩图片尺寸
 *
 *  @param image   原图
 *  @param newSize new Size
 *
 *  @return image
 */
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;


/**
 压缩图片小于一定的尺寸:先压缩质量再压缩体积（通过二分法压缩）
如果要保证图片清晰度，建议选择压缩图片质量。如果要使图片一定小于指定大小，压缩图片尺寸可以满足。对于后一种需求，还可以先压缩图片质量，如果已经小于指定大小，就可得到清晰的图片，否则再压缩图片尺寸。
 当图片大小小于 maxLength，大于 maxLength * 0.9 时，不再继续压缩。最多压缩 6 次，1/(2^6) = 0.015625 < 0.02，也能达到每次循环 compression减小 0.02 的效果。这样的压缩次数比循环减小 compression少，耗时短。需要注意的是，当图片质量低于一定程度时，继续压缩没有效果。也就是说，compression继续减小，data 也不再继续减小。
 压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；
 缺点在于，不能保证图片压缩后小于指定大小。
 @param image 图片
 @param maxLength 图片的最大值 KB
 @return 
 */
+ (UIImage *)compressWith:(UIImage *)image imageMaxLength:(NSInteger)imageMaxLength;

@end


