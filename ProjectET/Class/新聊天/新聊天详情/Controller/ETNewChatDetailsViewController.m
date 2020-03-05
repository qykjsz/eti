//
//  ETNewChatDetailsViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatDetailsViewController.h"
#import "ETNewChatGroupDetailsViewController.h"
#import "CTRongManager.h"
#import "ETNewChatGroupDetailsModel.h"

//#import "RealTimeLocationEndCell.h"
//#import "RealTimeLocationStartCell.h"
//#import "RealTimeLocationStatusView.h"
//#import "RealTimeLocationViewController.h"

@interface ETNewChatDetailsViewController ()

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *useName;

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) UIButton *rightBtn;


@end

@implementation ETNewChatDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 0, 30, 30);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setImage:[UIImage imageNamed:@"fh_icon"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    if (self.conversationType == ConversationType_GROUP) {
        [self getrongyunGroup];
    }else {
        [self getChatSelusernameDuiFang];;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //统一导航条样式
    //设置需要显示哪些类型的会话,由于楼主只需要单聊功能,所以只设置ConversationType_PRIVATE
    [self getChatSelusername];
    [self setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
    [self.chatSessionInputBarControl.pluginBoardView removeItemAtIndex:1];
    [[RCIM sharedRCIM] setEnableMessageAttachUserInfo:YES];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 0, 30, 30);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setImage:[UIImage imageNamed:@"fh_icon"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 15, 15);
    [self.rightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.rightBtn.layer.cornerRadius = 3;
    self.rightBtn.layer.masksToBounds = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    if (self.conversationType == ConversationType_GROUP) {
        
        [self getChatGroupusers];
        //        [self getrongyunGroup];
        [HYNRCDData getGroupInfoWithGroupId:self.targetId completion:^(RCGroup * _Nonnull groupInfo) {
            
        }];
    }else {
        
    }
    
    [RCIM sharedRCIM].globalNavigationBarTintColor = UIColorFromHEX(0x333333, 1);
    self.navigationController.navigationBar.tintColor =  UIColorFromHEX(0x333333, 1);
    //    self.enableSaveNewPhotoToLocalSystem = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:true];
}


- (void)rightBtnAction{
    
    if (self.conversationType == ConversationType_GROUP) {
        [self getrongyunIsInGroup];
    }else {
        ETNewChatGroupDetailsViewController *vc = [ETNewChatGroupDetailsViewController new];
        vc.tid  = self.targetId;
        [self.navigationController pushViewController:vc animated:true];
    }
    
    
    
}

- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageContent{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    RCUserInfo *uses = [[RCUserInfo alloc]initWithUserId:model.ryID name:self.useName portrait:self.url];
    messageContent.senderUserInfo = uses;
    return messageContent;
    
}

//

///搜索好友
- (void)getChatSelusername{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_getuser_id" parameters:@{@"id":[NSString stringWithFormat:@"%@",model.ryID]} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.url = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]];
            self.useName = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
            self.ID = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"id"]];
            //            self.title = self.useName;
        }else{
            [KMPProgressHUD showText:baseModel.msg];
            //            [self.navigationController popViewControllerAnimated:true];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


///好友列表
- (void)getChatGroupusers{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_groupsuser" parameters:@{@"qid":self.targetId} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            ETNewChatGroupDetailsModel *model1 =[ETNewChatGroupDetailsModel mj_objectWithKeyValues:responseObject];
            for (ETNewChatGroupDetailsDataModel *data in model1.data) {
                if ([data.ID isEqualToString:model.ryID]) {
                    [self.rightBtn setImage:[UIImage imageNamed:@"…"] forState:UIControlStateNormal];
                    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
                    return ;
                }
            }
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
        //        [self.tableView reloadData];
    }];
}


///搜索好友
- (void)getChatSelusernameDuiFang{
    //    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_getuser_id" parameters:@{@"id":[NSString stringWithFormat:@"%@",self.targetId]} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            
            self.title = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
        }else{
            [KMPProgressHUD showText:baseModel.msg];
            //            [self.navigationController popViewControllerAnimated:true];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


///修改昵称
- (void)getrongyunGroup{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_group" parameters:@{@"qid":self.targetId} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.title = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
        }
        //        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


///查询成员是否在群里
- (void)getrongyunIsInGroup{
    [SVProgressHUD showWithStatus:@""];
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_isinqroup" parameters:@{@"qid":self.targetId,@"tid":model.ryID} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            ETNewChatGroupDetailsViewController *vc = [ETNewChatGroupDetailsViewController new];
            vc.tid  = self.targetId;
            if ([vc.fromGroupType isEqualToString:@"1"]) {
                vc.fromGroupType = self.fromGroupType;
            }
            
            [self.navigationController pushViewController:vc animated:true];
        }else {
            [KMPProgressHUD showText:baseModel.msg];
        }
        //
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion{
    
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
