//
//  ETAddFriendInformationViewController.m
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETAddFriendInformationViewController.h"

@interface ETAddFriendInformationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_address;

@end

@implementation ETAddFriendInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加好友";
    [self getChatSelusername];
    // Do any additional setup after loading the view from its nib.
}


///搜索好友
- (void)getChatSelusername{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"selusername" parameters:@{@"address":self.userName} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.lab_name.text = responseObject[@"data"][@"name"];
            self.lab_address.text = [NSString stringWithFormat:@"账号：%@",responseObject[@"data"][@"address"]];
            self.userName = responseObject[@"data"][@"address"];
            [self.img_img sd_setImageWithURL: [NSURL URLWithString:responseObject[@"data"][@"photo"]]];
            
        }else{
//            [self.navigationController popViewControllerAnimated:true];
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}


///添加好友
- (void)getChatAddchatfriend{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"addchatfriend" parameters:@{@"fromwho":model.address,@"towho":self.userName} type:kPOST success:^(id responseObject) {
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
- (IBAction)actionOfAddFriend:(UIButton *)sender {
    [self getChatAddchatfriend];
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
