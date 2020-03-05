//
//  ETNewChatFriendViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatFriendViewController.h"

@interface ETNewChatFriendViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf_name;

@end

@implementation ETNewChatFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友验证";
    [self getChatSelusername];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 52, 28);
        [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    rightBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    rightBtn.layer.cornerRadius = 3;
    rightBtn.layer.masksToBounds = YES;
        [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)actionOfTextChange:(UITextField *)sender {
    if (sender.text.length >= 20) {
        sender.text = [sender.text substringToIndex:20];
    }
    
}


///搜索好友
- (void)getChatSelusername{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_getuser_id" parameters:@{@"id":model.ryID} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.tf_name.text = [NSString stringWithFormat:@"我是%@",responseObject[@"data"][@"name"]];
        }else{
            [KMPProgressHUD showText:baseModel.msg];
//            [self.navigationController popViewControllerAnimated:true];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}


///搜索好友
- (void)getRongyunAddfriend{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_addfriend" parameters:@{@"uid":model.ryID,@"tid":self.ID,@"remarks":self.tf_name.text} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
     
            [self.navigationController popToRootViewControllerAnimated:true];
        }else{
            [KMPProgressHUD showText:baseModel.msg];
//            [self.navigationController popViewControllerAnimated:true];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}

- (void)rightBtnAction{
    [self getRongyunAddfriend];
   
}

///取消
- (IBAction)actionOfCancel:(UIButton *)sender {
    self.tf_name.text = @"";
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
