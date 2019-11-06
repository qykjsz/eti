//
//  UIImage+Watermark.m
//  KMPharmacy
//
//  Created by KM_MAC on 2018/7/31.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import "UIImage+Watermark.h"

@implementation UIImage (Watermark)
- (UIImage *)watermarkWithImage:(UIImage *)watermarkImage{
    
    CGRect frame = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContext(frame.size);
    [self drawInRect:frame];
    [watermarkImage drawInRect:frame];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

@end
