//
//  ETNewChatMineViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatMineViewController.h"
#import "ETNewChatChangeNameViewController.h"
#import "ETNewChatMineCodeViewController.h"
#import "ETShopChooseCoinView.h"

@interface ETNewChatMineViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,ETShopChooseCoinViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img_header;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_userName;

@end

@implementation ETNewChatMineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self getChatSelusername];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

///功能
- (IBAction)actionOfFunction:(UIButton *)sender {
    if (sender.tag - 600 == 0) {
        ETShopChooseCoinView *chooseView = [[ETShopChooseCoinView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        chooseView.lab_title.text = @"选择";
        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@{@"name":@"拍照"},@{@"name":@"从相册选择"}]];
        chooseView.delegate = self;
        [chooseView reloadChooseView:arr];
        [chooseView show];
    }else if (sender.tag - 600 == 1){
        ETNewChatChangeNameViewController *vc = [ETNewChatChangeNameViewController new];
        vc.name = self.lab_name.text ;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:true];
    }else if (sender.tag - 600 == 3){
        ETNewChatMineCodeViewController *vc = [ETNewChatMineCodeViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:true];
    }
}

///搜索好友
- (void)getChatSelusername{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_getuser_id" parameters:@{@"id":[NSString stringWithFormat:@"%@",model.ryID]} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.lab_userName.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"id"]];
            self.lab_name.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
            [self.img_header sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]]]];
            RCUserInfo *userInfo2=[[RCUserInfo alloc]initWithUserId:model.ryID name:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]] portrait:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]]];
             [[RCIM sharedRCIM]refreshUserInfoCache:userInfo2 withUserId:model.ryID];
        }else{
            [KMPProgressHUD showText:baseModel.msg];
//            [self.navigationController popViewControllerAnimated:true];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}

///修改头像
- (void)getChatChangeHeaderImg:(UIImage *)image {
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSData *data = UIImageJPEGRepresentation(image, 0.5f);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    
    [manager POST:[NSString stringWithFormat:@"%@rongyun_upmyphoto",APP_DOMAIN] parameters:@{@"uid":[NSString stringWithFormat:@"%@",model.ryID]} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"photo" fileName:@"photo.jpg" mimeType:@"image/jpg"];
    
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         self.img_header.image = image;
        NSLog(@"%@",JSON[@"msg"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
    }];
}


#pragma mark - ETShopChooseCoinViewDelegate
- (void)ETShopChooseCoinViewDelegateWithCell:(NSInteger)index{
    if (index == 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    UIImage *newImage = [self originImage:image scaleToSize:CGSizeMake(image.size.width, image.size.width)];
    
    [self getChatChangeHeaderImg:newImage];
  
    
    [picker dismissViewControllerAnimated:YES completion:^{}];

}

- (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
     
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
     
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
     
    UIGraphicsEndImageContext();
     
    return scaledImage;   //返回的就是已经改变的图片
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
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
