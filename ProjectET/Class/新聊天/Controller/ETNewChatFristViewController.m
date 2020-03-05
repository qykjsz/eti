//
//  ETNewChatFristViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatFristViewController.h"
#import "ETNewChatDetailsViewController.h"
#import "ETNewChatHeaderView.h"
#import "ETNewChatToolView.h"
#import "ETNewChatAddFriendAndGroupViewController.h"
#import "ETScanViewController.h"
#import "ETNewChatCreateGroupViewController.h"
#import "ETNewChatMineGroupModel.h"
#import "CTRongManager.h"
#import "ETNewChatNewFriendModel.h"
@interface ETNewChatFristViewController ()<ETNewChatToolViewDelegate,RCIMReceiveMessageDelegate>

@property (nonatomic, strong)UIView *whitView;

@property (nonatomic, strong) NSString *uid;

@property (nonatomic, strong) ETNewChatToolView *toolView;

@property (nonatomic,strong)ETNewChatMineGroupModel *model;

@property (nonatomic, strong) NSMutableArray *userDataSource;

@property (nonatomic, strong) NSMutableArray *selDataSource;

@property (nonatomic, strong) NSMutableArray *chatDataSource;

@end

@implementation ETNewChatFristViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.toolView hiddenTool];
  
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.conversationListTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userDataSource = [NSMutableArray array];
    self.selDataSource = [NSMutableArray array];
    self.chatDataSource = [NSMutableArray array];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
    //    [self setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
    //设置需要显示哪些类型的会话,由于楼主只需要单聊功能,所以只设置ConversationType_PRIVATE
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    self.conversationListTableView.separatorStyle = UITableViewCellAccessoryNone;
    self.whitView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    self.whitView.clipsToBounds = YES;
    self.whitView.layer.cornerRadius = 25;
    self.whitView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.whitView];
    [self.conversationListTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self.view).offset(5);
        make.right.mas_equalTo(self.view).offset(-5);
    }];
    self.conversationListTableView.clipsToBounds = YES;
    self.conversationListTableView.layer.cornerRadius = 26;
    [self.view bringSubviewToFront:self.conversationListTableView];
    //    self.conversationListTableView.tableHeaderView = self.headerView;
    
    UIButton * toolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    toolBtn.layer.cornerRadius = 30;
    toolBtn.layer.masksToBounds = YES;
    [toolBtn setImage:[UIImage imageNamed:@"lt_gn_icon"] forState:UIControlStateNormal];
    [toolBtn addTarget:self action:@selector(toolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toolBtn];
    [toolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.width.height.equalTo(@60);
    }];
   
    [self connectToRongCloud];
//    [self getChatGroupusers];
//    [self getRongyunMyfriends];
    // Do any additional setup after loading the view from its nib.
}

- (void)connectToRongCloud{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    if (model.ryToken) {
        [[RCIM sharedRCIM] connectWithToken:model.ryToken success:^(NSString *userId) {
            model.ryID = userId;
            [ETWalletManger updateWallet:model];
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    }else {
        [SVProgressHUD showWithStatus:@""];
        [HTTPTool requestDotNetWithURLString:@"rongyun_gettoken" parameters:@{@"address":model.address}    type:kPOST success:^(id responseObject) {
            KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
            if (baseModel.code == 200) {
                model.ryToken = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"token"]];
                
                [ETWalletManger updateWallet:model];
                [[RCIM sharedRCIM] connectWithToken:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"token"]] success:^(NSString *userId) {
                    model.ryID = userId;
                    [ETWalletManger updateWallet:model];
                    NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                } error:^(RCConnectErrorCode status) {
                    NSLog(@"登陆的错误码为:%ld", (long)status);
                } tokenIncorrect:^{
                    //token过期或者不正确。
                    //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                    //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                    NSLog(@"token错误");
                }];
            }else {
                
            }
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [SVProgressHUD dismiss];
        }];
    }
    
}


- (void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
}

/////还有列表
//- (void)getRongyunMyfriends{
//    ETWalletModel *model = [ETWalletManger getCurrentWallet];
//    [SVProgressHUD showWithStatus:@""];
//    [HTTPTool requestDotNetWithURLString:@"rongyun_myfriends" parameters:@{@"uid":model.ryID,@"data_type":@"data"} type:kPOST success:^(id responseObject) {
//        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
//        if (baseModel.code == 200) {
//            ETNewChatNewFriendModel *model1 = [ETNewChatNewFriendModel mj_objectWithKeyValues:responseObject];
//                for (NSString *tagId in self.userDataSource) {
//                    for (ETNewChatNewFriendDataModel *data in model1.data) {
//                        if ([tagId isEqualToString:data.ID]) {
//                            [self.userDataSource removeObject:tagId];
//                        }
//                    }
//                   
//                }
//            
//            for (NSString *ID in self.userDataSource) {
//                for (RCConversationModel *model2 in self.chatDataSource) {
//                    if ([model2.targetId isEqualToString:ID]) {
//                        [self.conversationListDataSource removeObject:model2];
//                    }
//                }
//            }
//            
//            [self.conversationListTableView reloadData];
//        }else{
////            [KMPProgressHUD showText:baseModel.msg];
//            //            [self.navigationController popViewControllerAnimated:true];
//        }
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
//        
//        
//    }];
//}


- (void)toolBtnAction:(UIButton *)sender{
    
    self.toolView = [[ETNewChatToolView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight)];
    self.toolView.delegate = self;
    [self.toolView show];
    
}



#pragma mark - ETNewChatToolViewDelegate
///0创建群聊 1添加好友 2扫一扫
- (void)ETNewChatToolViewDelegate:(NSInteger)tag{
    if (tag == 0) {
        ETNewChatCreateGroupViewController *vc = [ETNewChatCreateGroupViewController new];
        vc.type = 0;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:true];
    }else if (tag == 1) {
        ETNewChatAddFriendAndGroupViewController *vc = [ETNewChatAddFriendAndGroupViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:true];
    }else if (tag == 2){
        ETScanViewController *cVC = [ETScanViewController new];
        cVC.isDirection = YES;
        cVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cVC animated:YES];
    }
}


//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    ETNewChatDetailsViewController *conversationVC = [[ETNewChatDetailsViewController alloc]init];
    
    //聊天界面的聊天类型
    conversationVC.conversationType = model.conversationType;
    //需要打开和谁聊天的会话界面,和谁聊天其实是通过TargetId来联系的。
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"聊天";
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:true];
}


//- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource{
//    [self.userDataSource removeAllObjects];
//    [self.selDataSource removeAllObjects];
//    [self.chatDataSource removeAllObjects];
//    for (RCConversationModel *model in dataSource) {
//        if (model.conversationType == ConversationType_PRIVATE) {
//            [self.userDataSource addObject:model.targetId];
//        }
//
//    }
//    [self.chatDataSource addObjectsFromArray:dataSource];
//    [self getRongyunMyfriends];
//
//    return dataSource;
//}

#pragma mark - RCIMReceiveMessageDelegate
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
//    if (message.conversationType == ConversationType_SYSTEM) {
//            RCTextMessage*textMsg = (RCTextMessage *)message.content;
//        NSLog(@"新消息==%@附加消息==%@",textMsg.content,textMsg.extra);
//        NSDictionary *dic = [Tools dictionaryWithJsonString:textMsg.extra];
//        if ([[NSString stringWithFormat:@"%@",dic[@"type"]] isEqualToString:@"3"]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self getRongyunMyfriends];
//            });
//
//        }
//    }

   
    
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
