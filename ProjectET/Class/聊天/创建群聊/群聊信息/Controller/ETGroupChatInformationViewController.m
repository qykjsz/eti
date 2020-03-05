//
//  ETGroupChatInformationViewController.m
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETGroupChatInformationViewController.h"
#import "ETGroupOfShareViewController.h"
#import "ETGroupMembersViewController.h"
#import "ETGroupTransferViewController.h"
#import "ETFriendAndGroupCodeViewController.h"

@interface ETGroupChatInformationViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switchON;
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_introduce;
@property (weak, nonatomic) IBOutlet UILabel *lab_qcode;
@property (weak, nonatomic) IBOutlet UILabel *lab_numbet;
@property (weak, nonatomic) IBOutlet UILabel *lab_titleImg;

@property (nonatomic, strong) NSDictionary *groupDic;

@property (nonatomic, strong) NSString *owne;

@end

@implementation ETGroupChatInformationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getChatGroupinformation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群聊信息";
    self.switchON.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [self.switchON mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(37.5);
        make.height.offset(21.5);
    }];
    
    // Do any additional setup after loading the view from its nib.
}

///0群名称 1群分享 2群人数 3转让群
- (IBAction)actionOfGroupTag:(UIButton *)sender {
    
    if (sender.tag - 500 == 0) {
        
    }else if (sender.tag - 500 == 1) {
        ETFriendAndGroupCodeViewController *vc = [ETFriendAndGroupCodeViewController new];
        vc.dic = self.groupDic;
        vc.flag = NO;
        [self.navigationController pushViewController:vc animated:true];
    }else if (sender.tag - 500 == 2) {
        ETGroupMembersViewController *vc = [ETGroupMembersViewController new];
        vc.qcode = self.qcode;
        [self.navigationController pushViewController:vc animated:true];
    }else if (sender.tag - 500 == 3) {
        if ([self.owne isEqualToString:@"1"]) {
            ETGroupTransferViewController *vc = [ETGroupTransferViewController new];
            vc.qcode = self.qcode;
            [self.navigationController pushViewController:vc animated:true];
        }
        
    }
}
- (IBAction)actionOfSwitch:(UISwitch *)sender {
    if (sender.on) {
        [self getChatGroupverification:@"1"];
    }else{
        [self getChatGroupverification:@"2"];
    }
}

///群组信息
- (void)getChatGroupinformation{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"groupinformation" parameters:@{@"address":model.address,@"qcode":self.qcode} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.groupDic = @{@"chatCode":[NSString stringWithFormat:@"%@", responseObject[@"data"][@"code"]]};
            self.lab_name.text = responseObject[@"data"][@"name"];
            self.lab_titleImg.text = [responseObject[@"data"][@"name"] substringToIndex:1];
            self.lab_qcode.text = responseObject[@"data"][@"code"];
            self.qcode = responseObject[@"data"][@"code"];
            [self.img_img sd_setImageWithURL: [NSURL URLWithString:responseObject[@"data"][@"photo"]]];
            self.lab_introduce.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"introduce"]] ;
            self.lab_numbet.text = [NSString stringWithFormat: @"%@",responseObject[@"data"][@"number"]] ;
            self.owne = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"owner"]];
            if ([[NSString stringWithFormat: @"%@",responseObject[@"data"][@"verification"]] isEqualToString:@"1"]) {
                [self.switchON setOn:true];
            }else {
                [self.switchON setOn:false];
            }
            
            if ([[NSString stringWithFormat: @"%@",responseObject[@"data"][@"owner"]] isEqualToString:@"2"]) {
                [self.switchON setEnabled:false];
            }
        }else{
            [self.navigationController popViewControllerAnimated:true];
            [KMPProgressHUD showText:baseModel.msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}

///退出群聊
- (void)getChatGroupout{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"groupout" parameters:@{@"address":model.address,@"qcode":self.qcode} type:kPOST success:^(id responseObject) {
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

///开启是否验证
- (void)getChatGroupverification:(NSString *)veri{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"groupverification" parameters:@{@"address":model.address,@"code":self.qcode,@"verification":veri} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            
        }else{
            
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}

- (IBAction)actionOfOutGroup:(UIButton *)sender {
    [self getChatGroupout];
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
