//
//  ETCreateGroupChatViewController.m
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETCreateGroupChatViewController.h"
#import "ETGroupChatInformationViewController.h"
#import "XXTextView.h"

@interface ETCreateGroupChatViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet XXTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *lab_strLength;
@property (weak, nonatomic) IBOutlet UITextField *tf_name;


@end

@implementation ETCreateGroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建群聊";
    self.textView.xx_placeholderFont = [UIFont systemFontOfSize:14];
    // Do any additional setup after loading the view from its nib.
}

///创建群
- (void)getChatAddgroup{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"addgroup" parameters:@{@"address":model.address,
                                                                  @"name" : self.tf_name.text,
                                                                  @"introduce" : self.textView.text
    } type:kPOST success:^(id responseObject) {
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

- (IBAction)actionTextFieldEditingChanged:(UITextField *)sender {
    if (sender.text.length >= 20) {
        sender.text = [sender.text substringToIndex:20];
    }
}

- (IBAction)actionOfCreateGroup:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.tf_name.text.length == 0) {
        [KMPProgressHUD showText:self.tf_name.placeholder];
        return;
    }
    
    if (self.textView.text.length == 0) {
        [KMPProgressHUD showText:@"请填写群简介"];
        return;
    }
    
    [self getChatAddgroup];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length >= 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    self.lab_strLength.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
}

//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//   if (textView.text.length <= 300) {
//             self.lab_strLength.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
//          return YES;
//         }else {
//             return NO;
//         }
//}
//
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    if (textView.text.length <= 300) {
//              self.lab_strLength.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
//           return YES;
//          }else {
//              return NO;
//          }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
