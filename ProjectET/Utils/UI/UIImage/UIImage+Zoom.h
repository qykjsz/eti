//
//  UIImage+Zoom.h
//  KMPharmacy
//
//  Created by wangxun on 2018/5/15.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Zoom)
/**
 *按比例缩放,size是你要把图显示到 多大区域 ,例如:CGSizeMake(300, 400)
 */
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
/**
 *指定宽度按比例缩放
 */
-(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
