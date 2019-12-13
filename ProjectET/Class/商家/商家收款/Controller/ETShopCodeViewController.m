//
//  ETShopCodeViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETShopCodeViewController.h"
#import "KMPQRCodeManager.h"
#import "ETShopSetMoneyViewController.h"
#import "ETShopRecordViewController.h"
#import <Photos/Photos.h>
@interface ETShopCodeViewController ()<ETShopSetMoneyViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img_code;

@end

@implementation ETShopCodeViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSDictionary *dic = @{@"address":model.address};
//    [self generateCode:[Tools dataTojsonString:dic]];
     self.img_code.image = [KMPQRCodeManager createQRCode:[Tools dataTojsonString:dic] warterImage:nil];
    // Do any additional setup after loading the view from its nib.
}

///设置金额
- (IBAction)actionOfSetMoney:(UIButton *)sender {
    ETShopSetMoneyViewController *vc = [ETShopSetMoneyViewController new];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:true];
}

///保存图片
- (IBAction)actionOfSave:(UIButton *)sender {
    
    [self saveImageToPhotos:self.img_code.image];
}

///收款记录
- (IBAction)actionOfRecord:(UIButton *)sender {
    ETShopRecordViewController *vc = [ETShopRecordViewController new];
       vc.hidesBottomBarWhenPushed = YES;
       [self.navigationController pushViewController:vc animated:true];
}

///返回
- (IBAction)actionOfBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)saveImageToPhotos:(UIImage*)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if(error != nil){
        [KMPProgressHUD showText:@"保存图片失败"];

    }else{
        [KMPProgressHUD showText:@"保存图片成功"];
    }
}

- (void)ETShopSetMoneyViewControllerDelegateWithCell:(NSString *)jsonStr{
//    [self generateCode:jsonStr];
    self.img_code.image = [KMPQRCodeManager createQRCode:jsonStr warterImage:nil];
}


//- (void)generateCode:(NSString *)str{
//     // 1. 创建一个二维码滤镜实例(CIFilter)
//        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//        // 滤镜恢复默认设置
//        [filter setDefaults];
//
//        // 2. 给滤镜添加数据
//        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//        // 使用KVC的方式给filter赋值
//        [filter setValue:data forKeyPath:@"inputMessage"];
//
//        // 3. 生成二维码
//        CIImage *image = [filter outputImage];
//
//        //4.在中心增加一张图片
//        UIImage *img = [self createNonInterpolatedUIImageFormCIImage:image withSize:SCREEN_WIDTH];
//
//        //5.把中央图片划入二维码里面
//        //5.1开启图形上下文
//        UIGraphicsBeginImageContext(img.size);
//        //5.2将二维码的图片画入
//        [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
//        UIImage *centerImg = [UIImage imageNamed:@"sys_tx"];
//        CGFloat centerW=img.size.width*0.3;
//        CGFloat centerH=centerW;
//        CGFloat centerX=(img.size.width-centerW)*0.5;
//        CGFloat centerY=(img.size.height -centerH)*0.5;
//        [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
//        //5.3获取绘制好的图片
//        UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
//        //5.4关闭图像上下文
//        UIGraphicsEndImageContext();
//
//        //6.显示最终二维码
//        self.img_code.image = finalImg;
//}
//
//- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
//{
//    CGRect extent = CGRectIntegral(image.extent);
//    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
//
//    //1.创建bitmap;
//    size_t width = CGRectGetWidth(extent) * scale;
//    size_t height = CGRectGetHeight(extent) * scale;
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//
//    //2.保存bitmap到图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    CGContextRelease(bitmapRef);
//    CGImageRelease(bitmapImage);
//    return [UIImage imageWithCGImage:scaledImage];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
