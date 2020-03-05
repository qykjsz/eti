//
//  ETGroupTransferViewController.m
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETGroupTransferViewController.h"

@interface ETGroupTransferViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf_address;
@property (weak, nonatomic) IBOutlet UITextField *tf_userName;

@end

@implementation ETGroupTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群转让";
    // Do any additional setup after loading the view from its nib.
}

///转让群
- (void)getChatUpgroupuser{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"upgroupuser" parameters:@{@"address":model.address,@"qcode":self.qcode,@"toaddress":self.tf_address.text} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            [self.navigationController popViewControllerAnimated:true];
        }else{
           
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}

///转让
- (IBAction)actionOfSure:(UIButton *)sender {
    [self.view endEditing:true];
    if (self.tf_address.text.length == 0) {
        [KMPProgressHUD showText:self.tf_address.placeholder];
        return;
    }
    
    [self getChatUpgroupuser];
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
