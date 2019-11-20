//
//  ETNewAlertsDetailsViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewAlertsDetailsViewController.h"
#import "KMPQRCodeManager.h"
#import <Photos/Photos.h>
@interface ETNewAlertsDetailsViewController ()<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_source;
@property (weak, nonatomic) IBOutlet UIImageView *img_code;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *view_bg;
@property (weak, nonatomic) IBOutlet UIImageView *img_title;

@end

@implementation ETNewAlertsDetailsViewController

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
    [self.textView setEditable:NO];
    self.lab_time.text = [self getTimeFromTimestamp:self.time];
    self.textView.text = [NSString stringWithFormat:@"  %@",self.content];
    self.lab_title.text = self.titleStr;
    self.lab_source.text = [NSString stringWithFormat:@"来源：%@",self.source];
    self.img_code.image = [KMPQRCodeManager createQRCode:self.url warterImage:nil];
    // Do any additional setup after loading the view from its nib.
}

///保存图片
- (IBAction)actionOfSavc:(UIButton *)sender {
    [self saveImage:[self screenShot]];
}


- (IBAction)actionOfBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveImage:(UIImage *)imge {
    
    WEAK_SELF(self);
    
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    
    if (photoAuthStatus == PHAuthorizationStatusNotDetermined) {
        
        // 未询问是否授权 可以用下面的请求授权方法询问用户
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                // 用户同意授权
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    STRONG_SELF(self);
                    //写入图片到相册
                    //                    dispatch_async(dispatch_get_main_queue(), ^{
                    [PHAssetChangeRequest creationRequestForAssetFromImage:imge];
                    //                    });
                    
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    
                    NSLog(@"success = %d, error = %@", success, error);
                }];
            }else {
                // 用户拒绝授权
            }
        }];
    }
    else if (photoAuthStatus == PHAuthorizationStatusRestricted || photoAuthStatus == PHAuthorizationStatusDenied) {
        // 未授权
        [self showLocationFailureAlert];
    }
    else {
        // 已授权
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            STRONG_SELF(self);
            //写入图片到相册
            //            dispatch_async(dispatch_get_main_queue(), ^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:imge];
            //            });
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            NSLog(@"success = %d, error = %@", success, error);
            
            if (success == YES) {
                [KMPProgressHUD showSuccessWithText:@"保存成功"];
            }
        }];
    }
}

- (void)showLocationFailureAlert {
    
    NSString *title = @"用户没有授权访问相册";
    NSString *message = @"用户没有授权访问相册时，无法为您提供保存图片到相册的功能，请您授权访问相册";
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ---- 截屏
- (UIImage *)screenShot {
      UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc]initWithBounds:CGRectMake(0, self.img_title.frame.origin.y - 35, SCREEN_WIDTH, self.view_bg.frame.size.height - CGRectGetMaxY(self.img_title.frame))];
      
        return [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            [self.view.layer renderInContext: rendererContext.CGContext];
        }];
}

#pragma mark ---- 将时间戳转换成时间

- (NSString *)getTimeFromTimestamp:(NSString *)time{
    
    //将对象类型的时间转换为NSDate类型
    
    //    double time =1504667976;
    
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    
    //设置时间格式
    
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    
    //将时间转换为字符串
    
    NSString *timeStr=[formatter stringFromDate:myDate];
    
    return timeStr;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
