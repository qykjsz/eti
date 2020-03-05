//
//  ETNewChatMineCodeViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatMineCodeViewController.h"
#import "KMPQRCodeManager.h"

@interface ETNewChatMineCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UIImageView *img_code;
@property (weak, nonatomic) IBOutlet UILabel *lab_ID;

@end

@implementation ETNewChatMineCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码名片";
    [self getChatSelusername];
    // Do any additional setup after loading the view from its nib.
}


///搜索好友
- (void)getChatSelusername{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_getuser_address" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.lab_ID.text = [NSString stringWithFormat:@"ID:%@",responseObject[@"data"][@"id"]];
            self.lab_name.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
            [self.img_img sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]]]];
            self.img_code.image = [KMPQRCodeManager createQRCode:[Tools dataTojsonString:@{@"chatCode":[NSString stringWithFormat:@"%@",responseObject[@"data"][@"id"]]}] warterImage:nil];
        }else{
            [KMPProgressHUD showText:baseModel.msg];
//            [self.navigationController popViewControllerAnimated:true];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}

///保存二维码
- (IBAction)actionOfSave:(UIButton *)sender {
    
     [self saveImageToPhotos:self.img_code.image];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
