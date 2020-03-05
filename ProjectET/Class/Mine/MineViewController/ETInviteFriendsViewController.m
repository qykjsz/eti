//
//  ETInviteFriendsViewController.m
//  ProjectET
//
//  Created by mac on 2019/12/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETInviteFriendsViewController.h"
#import "KMPQRCodeManager.h"
#import <Photos/Photos.h>
@interface ETInviteFriendsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img_code;
@property (nonatomic, strong) NSString *url;

@end

@implementation ETInviteFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请好友";
    [self updateApi];
    // Do any additional setup after loading the view from its nib.
}

- (void)updateApi {
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"api_update" parameters:@{@"type":@"ios"}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.url = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"download"]];
        self.img_code.image = [KMPQRCodeManager createQRCode:self.url warterImage:nil];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

///复制
- (IBAction)actionOfCopy:(UIButton *)sender {
    [Tools copyClickWithText:self.url];
}

///保存
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
