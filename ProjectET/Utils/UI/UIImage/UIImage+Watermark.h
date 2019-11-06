//
//  UIImage+Watermark.h
//  KMPharmacy
//
//  Created by KM_MAC on 2018/7/31.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Watermark)

/**
 <#Description#>

 @param watermarkImage 水印图片
 @return 组合后的图片
 */
- (UIImage *)watermarkWithImage:(UIImage *)watermarkImage;
@end
