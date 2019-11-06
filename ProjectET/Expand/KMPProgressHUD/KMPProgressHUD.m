//
//  KMSVProgressHUD.m
//  KMPharmacy
//
//  Created by KM_MAC on 2018/12/4.
//  Copyright © 2018 Kangmei Pharmaceutical Co.,Ltd. All rights reserved.
//

#import "KMPProgressHUD.h"
#import "SVProgressHUD.h"
#import "UIImage+GIFImage.h"
#import "Tools+Image.h"
@implementation KMPProgressHUD
singletonImplemention(KMPProgressHUD)

+ (void)dismissProgress {
    
    [SVProgressHUD dismiss];
}

+ (void)showText:(NSString *)text {
   
    [SVProgressHUD showImage:[UIImage imageNamed:@"yhlnull"] status:text];
//    [SVProgressHUD showImage:[Tools imageFromColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]] status:text];
    
    CGFloat minimum = MAX((CGFloat)text.length * 0.06 + 0.5, 5);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(minimum * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}

+ (void)showProgressWithText:(NSString *)text {
    
    [SVProgressHUD showImage:[UIImage imageWithGIFNamed:@"loading"] status:[NSString stringWithFormat:@"%@",text]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}

+ (void)showSuccessWithText:(NSString *)text {
    
    [KMPProgressHUD showText:text];
}

+ (void)showErrorWithText:(NSString *)text {
    
    [KMPProgressHUD showText:text];
}

+ (void)showProgress {
    
    [self showProgressWithText:@"加载中..."];
}

+ (void)showProgres:(float)progress {
    
    [self showProgressWithText:@"加载中..."];
}

+ (void)showSuccessWithText:(NSString *)text completion:(void (^)(void))completion {
    
    [self showText:text];
    
    NSTimeInterval time = [SVProgressHUD displayDurationForString:text];
    [[KMPProgressHUD sharedKMPProgressHUD] bk_performBlock:^(id obj) {
        [SVProgressHUD dismiss];
        if (completion) {
            completion();
        }
    } afterDelay:time];
    
}

+ (void)showErrorWithText:(NSString *)text completion:(void (^)(void))completion {
    
    [self showText:text];

    NSTimeInterval time = [SVProgressHUD displayDurationForString:text];
    [[KMPProgressHUD sharedKMPProgressHUD] bk_performBlock:^(id obj) {
        [SVProgressHUD dismiss];
        if (completion) {
            completion();
        }
    } afterDelay:time];
}


@end

