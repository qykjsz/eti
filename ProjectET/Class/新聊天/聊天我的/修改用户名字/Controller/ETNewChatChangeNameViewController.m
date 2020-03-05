//
//  ETNewChatChangeNameViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatChangeNameViewController.h"

@interface ETNewChatChangeNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf_name;

@end

@implementation ETNewChatChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    self.tf_name.text = self.name;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 52, 28);
        [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    rightBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    rightBtn.layer.cornerRadius = 3;
    rightBtn.layer.masksToBounds = YES;
        [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    // Do any additional setup after loading the view from its nib.
}

///修改昵称
- (void)getrongyunUpmyname{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_upmyname" parameters:@{@"uid":model.ryID,@"name":self.tf_name.text} type:kPOST success:^(id responseObject) {
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
    [self getrongyunUpmyname];
   
}

- (IBAction)actionOfTextChange:(UITextField *)sender {
    if (sender.text.length >= 20) {
        sender.text = [sender.text substringToIndex:20];
    }
    
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
