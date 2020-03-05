//
//  ETNewChatFriendRemarkViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatFriendRemarkViewController.h"

@interface ETNewChatFriendRemarkViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_name;

@end

@implementation ETNewChatFriendRemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
}


///搜索好友
- (void)getRongyunAddfriend{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_userremarks" parameters:@{@"uid":model.ryID,@"tid":self.ID,@"name":self.tf_name.text} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            [self.navigationController popToRootViewControllerAnimated:true];
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}


- (IBAction)actionOfTextChange:(UITextField *)sender {
    if (sender.text.length >= 20) {
        sender.text = [sender.text substringToIndex:20];
    }
    
}

- (void)rightBtnAction{
    if (self.tf_name.text.length == 0) {
        [KMPProgressHUD showText:self.tf_name.placeholder];
        return;
    }
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
