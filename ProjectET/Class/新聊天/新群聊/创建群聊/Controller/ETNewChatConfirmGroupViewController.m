//
//  ETNewChatConfirmGroupViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatConfirmGroupViewController.h"
#import "XXTextView.h"
#import "ETShopChooseCoinView.h"
@interface ETNewChatConfirmGroupViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,ETShopChooseCoinViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img_headr;
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet XXTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *lab_strLength;
@property (weak, nonatomic) IBOutlet UIButton *btn_group;

@end

@implementation ETNewChatConfirmGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建群聊";
    self.textView.xx_placeholderFont = [UIFont systemFontOfSize:14];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)actionOfTextChange:(UITextField *)sender {
    if (sender.text.length >= 20) {
        sender.text = [sender.text substringToIndex:20];
    }
    
}

///修改头像
- (void)getChatChangeHeaderImg{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
     [SVProgressHUD showWithStatus:@""];
    NSData *data = UIImageJPEGRepresentation([self originImage:self.img_headr.image scaleToSize:CGSizeMake(self.img_headr.image.size.width, self.img_headr.image.size.width)], 0.5f);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    
    [manager POST:[NSString stringWithFormat:@"%@rongyun_addgrop",APP_DOMAIN] parameters:@{@"uid":model.ryID,@"ids":self.ids,@"name":self.tf_name.text,@"introduce":self.textView.text} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"photo" fileName:@"photo.jpg" mimeType:@"image/jpg"];
    
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
       
               if (baseModel.code == 200) {
                   [self getrongyunUpmyname:JSON[@"data"][@"qid"]];
               }else {
                    [self.btn_group setEnabled:YES];
               }
               
               [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [self.btn_group setEnabled:YES];
         [SVProgressHUD dismiss];
    }];
}


///修改昵称
- (void)getrongyunUpmyname:(NSString *)qid{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_addmygroups" parameters:@{@"uid":model.ryID,@"qid":qid} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        
        if (baseModel.code == 200) {
     
             [self.navigationController popToRootViewControllerAnimated:true];
        }else{
            [KMPProgressHUD showText:baseModel.msg];
             [self.btn_group setEnabled:YES];
//            [self.navigationController popViewControllerAnimated:true];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
         [self.btn_group setEnabled:YES];
        [SVProgressHUD dismiss];


    }];
}

///限制字数
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length >= 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    self.lab_strLength.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
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


- (IBAction)actionOfSetImg:(UITapGestureRecognizer *)sender {
    [self.view endEditing:true];
    ETShopChooseCoinView *chooseView = [[ETShopChooseCoinView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
           chooseView.lab_title.text = @"选择";
           NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@{@"name":@"拍照"},@{@"name":@"从相册选择"}]];
           chooseView.delegate = self;
           [chooseView reloadChooseView:arr];
           [chooseView show];
}

///创建去聊
- (IBAction)actionOfGroup:(UIButton *)sender {
    if (self.tf_name.text.length == 0) {
        [KMPProgressHUD showText:self.tf_name.placeholder];
        return;
    }
    
    if (self.textView.text.length == 0) {
        [KMPProgressHUD showText:self.textView.xx_placeholder];
        return;
    }
    [self.btn_group setEnabled:false];
    [self getChatChangeHeaderImg];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    self.img_headr.image = image;
    
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
