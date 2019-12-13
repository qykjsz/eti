//
//  ETGatheringViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/1.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETGatheringViewController.h"
#import "ETRecordDetailViewController.h"
#import <Photos/Photos.h>
#import "KMPQRCodeManager.h"
#import "ETRecordSegmentController.h"
#import "MineRecordViewController.h"
@interface ETGatheringViewController ()

@property (nonatomic,strong) UIImageView *qcordeImage;

@property (nonatomic,strong) ETWalletModel *model;

@end
    
@implementation ETGatheringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.model = [ETWalletManger getCurrentWallet];
    
    
    self.title = @"二维码";
    UIButton *rightBarBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBarBtn setTitle:@"记录" forState:UIControlStateNormal];
    [rightBarBtn setTitleColor:UIColorFromHEX(0x000000, 1) forState:UIControlStateNormal];
    rightBarBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBarBtn addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBarBtn];
    
    
    UIScrollView *backScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backScro.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    backScro.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:backScro];
    
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 343)];
    topImage.userInteractionEnabled = YES;
    topImage.image = [UIImage imageNamed:@"sk_yykuang_01"];
    [backScro addSubview:topImage];

    
    UILabel *topTipsLb = [[UILabel alloc]init];
    topTipsLb.text = @"扫一扫, 向我付钱";
    topTipsLb.textColor = UIColorFromHEX(0x333333, 1);
    topTipsLb.font = [UIFont systemFontOfSize:14];
    [topImage addSubview:topTipsLb];
    [topTipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(topImage.mas_top).offset(46);
        
    }];
    
    self.qcordeImage = [[UIImageView alloc]init];
    self.qcordeImage.image = [KMPQRCodeManager createQRCode:self.model.address warterImage:nil];
    [topImage addSubview:self.qcordeImage];
    [self.qcordeImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(topTipsLb.mas_bottom).offset(18);
        make.width.height.equalTo(@180);
        
    }];
    
//    UIButton *leftBtn = [[UIButton alloc]init];
//    [leftBtn setTitle:@"设置金额" forState:UIControlStateNormal];
//    [leftBtn setTitleColor:UIColorFromHEX(0x1D57FF, 1) forState:UIControlStateNormal];
//    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    leftBtn.tag = 0;
//    [leftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [topImage addSubview:leftBtn];
//    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.qcordeImage.mas_left);
//        make.top.equalTo(self.qcordeImage.mas_bottom).offset(30);
//        make.height.mas_equalTo(14);
//        make.width.mas_equalTo(58);
//
//    }];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"保存图片" forState:UIControlStateNormal];
    rightBtn.tag = 1;
    [rightBtn setTitleColor:UIColorFromHEX(0x1D57FF, 1) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.right.equalTo(self.qcordeImage.mas_right);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.qcordeImage.mas_bottom).offset(30);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(58);
        
    }];
    
    UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(topImage.frame) + 10, SCREEN_WIDTH - 20, 190)];
    bottomImage.userInteractionEnabled = YES;
    bottomImage.image = [UIImage imageNamed:@"sk_yykuang_01"];
    [backScro addSubview:bottomImage];
    
    UILabel *bottomTipsLb = [[UILabel alloc]init];
    bottomTipsLb.text = @"收款地址";
    bottomTipsLb.textColor = UIColorFromHEX(0x333333, 1);
    bottomTipsLb.font = [UIFont systemFontOfSize:14];
    [bottomImage addSubview:bottomTipsLb];
    [bottomTipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(bottomImage.mas_centerX);
        make.top.equalTo(bottomImage.mas_top).offset(20);
        
    }];
    
    UILabel *addressLb = [[UILabel alloc]init];
    addressLb.font = [UIFont systemFontOfSize:14];
    addressLb.numberOfLines = 3;
    addressLb.textAlignment = NSTextAlignmentCenter;
    addressLb.textColor = UIColorFromHEX(0x1D57FF, 1);
    addressLb.text = self.model.address;
    [bottomImage addSubview:addressLb];
    [addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(bottomImage.mas_left).offset(10);
        make.right.equalTo(bottomImage.mas_right).offset(-10);
        make.top.equalTo(bottomTipsLb.mas_bottom).offset(15);
        
    }];
    
    UIButton *bottomBtn = [[UIButton alloc]init];
    [bottomBtn setTitle:@"复制收款地址" forState:UIControlStateNormal];
    bottomBtn.tag = 2;
    bottomBtn.clipsToBounds = YES;
    bottomBtn.layer.cornerRadius = 5;
    bottomBtn.backgroundColor =UIColorFromHEX(0x1D57FF, 1);
    [bottomBtn setTitleColor:UIColorFromHEX(0xffffff, 1) forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomImage addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bottomImage.mas_left).offset(40);
        make.right.equalTo(bottomImage.mas_right).offset(-40);
        make.top.equalTo(addressLb.mas_bottom).offset(30);
        make.height.mas_equalTo(44);

    }];
    
}


#pragma mark - Action
- (void)recordAction {
    
    MineRecordViewController *dVC = [MineRecordViewController new];
    [self.navigationController pushViewController:dVC animated:YES];
    
}

- (void)clickAction:(UIButton *)sender {
    
    // 0设置金额 1保存图片 2复制收款地址
    if (sender.tag == 0) {
        
       // [self setMoneyAction];
        [self setMoneyAction:^(NSString *str) {
           
            NSLog(@"%@",str);
            
        }];
        
    }else if (sender.tag == 1){
        
        [self saveImage];
        
    }else {
        
        [Tools copyClickWithText:self.model.address];
        
    }
    
}

- (void)saveImage {
    
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
                         [PHAssetChangeRequest creationRequestForAssetFromImage:self.qcordeImage.image];
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
                [PHAssetChangeRequest creationRequestForAssetFromImage:self.qcordeImage.image];
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

- (void)setMoneyAction:(void (^)(NSString *))str {
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"请设置金额" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输金额";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
    }];
    
    [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *envirnmentNameTextField = alter.textFields.firstObject;
        
        str(envirnmentNameTextField.text);
       
      //  NSLog(@"%@",envirnmentNameTextField);
    }]];
    
    //添加一个取消按钮
    [alter addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
 
    [self.navigationController presentViewController:alter animated:YES completion:nil];
   
}



@end
