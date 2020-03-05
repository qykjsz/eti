//
//  ETAddGroupInformationViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/2.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETAddGroupInformationViewController.h"

@interface ETAddGroupInformationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UILabel *lab_introduce;
@property (weak, nonatomic) IBOutlet UILabel *lab_titleImg;

@end

@implementation ETAddGroupInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加群组";
    [self getChatGroupinformation];
    // Do any additional setup after loading the view from its nib.
}

///搜索群组
- (void)getChatGroupinformation{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"groupinformation" parameters:@{@"address":model.address,@"qcode":self.qcode} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.lab_name.text = responseObject[@"data"][@"name"];
            self.lab_titleImg.text = [responseObject[@"data"][@"name"] substringToIndex:1];
            self.lab_address.text = [NSString stringWithFormat:@"群ID：%@",responseObject[@"data"][@"code"]];
            self.qcode = responseObject[@"data"][@"code"];
//            [self.img_img sd_setImageWithURL: [NSURL URLWithString:responseObject[@"data"][@"photo"]]];
            self.lab_introduce.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"introduce"]];
            
        }else{
//            [self.navigationController popViewControllerAnimated:true];
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}

///添加群组
- (void)getChatUseraddgroup{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"useraddgroup" parameters:@{@"address":model.address,@"code":self.qcode} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            [self.navigationController popViewControllerAnimated:true];
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}



- (IBAction)actionOfAddGroup:(UIButton *)sender {
    [self getChatUseraddgroup];
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
