//
//  ETNewChatAddFriendAndGroupViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatAddFriendAndGroupViewController.h"
#import "ETNewChatAddFriendViewController.h"

@interface ETNewChatAddFriendAndGroupViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lab_search;
@property (weak, nonatomic) IBOutlet UILabel *lab_searchGroup;

@end

@implementation ETNewChatAddFriendAndGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加好友";
    self.tf_search.text = self.code;
    self.lab_search.text = self.code;
    self.lab_searchGroup.text = self.code;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)actionOfTextFiedlChanged:(UITextField *)sender {
    self.lab_search.text = self.tf_search.text;
    self.lab_searchGroup.text = self.tf_search.text;
}

///添加好友
- (IBAction)acitonOfAddFriends:(id)sender {
    if (self.tf_search.text.length == 0) {
        [KMPProgressHUD showText:self.tf_search.placeholder];
        return;
    }
    [self getChatSelusername];
}
///添加群组
- (IBAction)actionOfAddGroup:(id)sender {
    if (self.tf_search.text.length == 0) {
           [KMPProgressHUD showText:self.tf_search.placeholder];
           return;
       }
    [self getChatGroupinformation];
}


///搜索好友
- (void)getChatSelusername{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_getuser_id" parameters:@{@"id":self.lab_search.text} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            ETNewChatAddFriendViewController *vc = [ETNewChatAddFriendViewController new];
            vc.address = self.lab_search.text;
            [self.navigationController pushViewController:vc animated:true];
            
        }else{
            [KMPProgressHUD showText:baseModel.msg];
//            [self.navigationController popViewControllerAnimated:true];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}


///搜索群组
- (void)getChatGroupinformation{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_group" parameters:@{@"qid":self.lab_searchGroup.text} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
//            ETAddGroupInformationViewController *vc = [ETAddGroupInformationViewController new];
//            vc.qcode = self.lab_searchGroup.text;
//            [self.navigationController pushViewController:vc animated:true];
        }else{
             [KMPProgressHUD showText:baseModel.msg];
        }
      
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
