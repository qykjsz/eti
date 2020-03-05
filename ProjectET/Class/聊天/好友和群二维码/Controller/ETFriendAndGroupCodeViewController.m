//
//  ETFriendAndGroupCodeViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETFriendAndGroupCodeViewController.h"
#import "KMPQRCodeManager.h"

@interface ETFriendAndGroupCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img_immg;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_msg;
@property (weak, nonatomic) IBOutlet UIImageView *img_code;
@property (weak, nonatomic) IBOutlet UILabel *lab_imgTitle;

@end

@implementation ETFriendAndGroupCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.flag) {
        self.title = @"我的二维码";
        [self getChatSelusername];
    }else{
        self.title = @"群分享";
        [self getChatGroupinformation];
    }
    NSLog(@"%@",self.dic);
    // Do any additional setup after loading the view from its nib.
}

///搜索好友
- (void)getChatSelusername{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"selusername" parameters:@{@"address":self.dic[@"chatCode"]} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            [self.img_immg sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"photo"]]];
            self.lab_imgTitle.text = @"";
            self.lab_name.text = responseObject[@"data"][@"name"];
            self.lab_msg.text = @"扫一扫二维码，加我好友";
            self.img_code.image = [KMPQRCodeManager createQRCode:[Tools dataTojsonString:self.dic] warterImage:nil];
            
        }else{
//            [self.navigationController popViewControllerAnimated:true];
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}

///搜索群组
- (void)getChatGroupinformation{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"groupinformation" parameters:@{@"address":model.address,@"qcode":self.dic[@"chatCode"]} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.lab_imgTitle.text = [responseObject[@"data"][@"name"] substringToIndex:1];
            self.img_immg.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
            self.lab_name.text = responseObject[@"data"][@"name"];
            self.lab_msg.text = @"扫一扫二维码，加入群聊";
            self.img_code.image = [KMPQRCodeManager createQRCode:[Tools dataTojsonString:self.dic] warterImage:nil];
            
        }else{
//            [self.navigationController popViewControllerAnimated:true];
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
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
