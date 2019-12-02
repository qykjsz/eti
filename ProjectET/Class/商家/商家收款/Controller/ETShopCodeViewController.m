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
    self.img_code.image = [KMPQRCodeManager createQRCode:jsonStr warterImage:nil];
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
