//
//  ETNewChatGroupCodeViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatGroupCodeViewController.h"
#import "KMPQRCodeManager.h"
@interface ETNewChatGroupCodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UIImageView *img_code;

@end

@implementation ETNewChatGroupCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群二维码名片";
    self.img_code.image = [KMPQRCodeManager createQRCode:[Tools dataTojsonString:@{@"chatCode":self.tid}] warterImage:nil];
    // Do any additional setup after loading the view from its nib.
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
