//
//  KMPQRCodeManager.h
//  KMPharmacy
//
//  Created by cjl on 2018/7/16.
//  Copyright © 2018年 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KMPQRCodeManager : NSObject

/**
 生成二维码
 
 @param string 数据
 @param warterImage 水印log
 @return 二维码
 */
+ (id)createQRCode:(NSString *)string warterImage:(UIImage *)warterImage;


@end
