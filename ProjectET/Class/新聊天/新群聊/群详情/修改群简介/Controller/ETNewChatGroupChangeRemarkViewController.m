//
//  ETNewChatGroupChangeRemarkViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatGroupChangeRemarkViewController.h"
#import "XXTextView.h"

@interface ETNewChatGroupChangeRemarkViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet XXTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *lab_strLength;

@end

@implementation ETNewChatGroupChangeRemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群简介";
    self.textView.text = self.remark;
    [self textViewDidChange:self.textView];
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
    [HTTPTool requestDotNetWithURLString:@"rongyun_upgroupintroduce" parameters:@{@"uid":model.ryID,@"introduce":self.textView.text,@"qid":self.tid} type:kPOST success:^(id responseObject) {
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

- (void)rightBtnAction{
    if (self.textView.text.length == 0) {
        [KMPProgressHUD showText:self.textView.xx_placeholder];
        return;
    }
    [self getrongyunUpmyname];
    
}

///限制字数
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length >= 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    self.lab_strLength.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
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
