//
//  ETNewChatAddressFriendSetViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatAddressFriendSetViewController.h"
#import "ETNewChatFriendRemarkViewController.h"

#import "ETNewChatNewFriendModel.h"

@interface ETNewChatAddressFriendSetViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switch_btn;

@property (nonatomic,strong)ETNewChatNewFriendModel *model2;

@end

@implementation ETNewChatAddressFriendSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料设置";
    [self getRongyunBlacklist];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)actionOfSwitch:(UISwitch *)sender {
    NSLog(@"%lu",(unsigned long)sender.isOn);
    
    if (sender.isOn == 1) {
        [self getRongyunAddblacklist];
    }else {
        [self getRongyunDelblacklist];
    }
    
    
}

///添加黑名单
- (void)getRongyunAddblacklist{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_addblacklist" parameters:@{@"uid":model.ryID,@"tid":self.uid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
           
        }
        
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
    }];
}

///移除黑名单
- (void)getRongyunDelblacklist{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_delblacklist" parameters:@{@"uid":model.ryID,@"tid":self.uid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
           
        }
        
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
    }];
}


///删除好友
- (void)getRongyunDelmyfriend{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_delmyfriend" parameters:@{@"uid":model.ryID,@"tid":self.uid} type:kPOST success:^(id responseObject) {
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


///好友列表
- (void)getRongyunBlacklist{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_blacklist" parameters:@{@"uid":model.ryID} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.model2 =[ETNewChatNewFriendModel mj_objectWithKeyValues:responseObject];
            for (ETNewChatNewFriendDataModel *dModel in self.model2.data) {
                if ([dModel.ID isEqualToString:self.uid]) {
                    [self.switch_btn setOn:YES];
                }
            }
        }
    } failure:^(NSError *error) {
    }];
}

///备注
- (IBAction)actionOfRemark:(UIButton *)sender {
    ETNewChatFriendRemarkViewController *vc = [ETNewChatFriendRemarkViewController new];
    vc.ID = self.uid;
    [self.navigationController pushViewController:vc animated:true];
}

///删除好友
- (IBAction)actionOfDel:(UIButton *)sender {
    [self getRongyunDelmyfriend];
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
