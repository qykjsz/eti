//
//  ETChatViewcontroller.m
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETChatViewcontroller.h"
#import "ETVerifyPassWrodView.h"
#import "ETChatCell.h"
#import "ETAddFriendsPopView.h"
#import "ETAddFriendsViewController.h"
#import "ETCreateGroupChatViewController.h"
#import "ETAddressBookViewController.h"
#import "ETChatLishModel.h"
#import "ETCharGroupAndFriendNoticeViewController.h"
#import "ETChatDetailsViewController.h"
#import "ETSocketHelper.h"
#import "ETChatDetailsModel.h"
#import "ETChatGroupDetailsViewController.h"
#import "ETScanViewController.h"

@interface ETChatViewcontroller ()

@property (nonatomic,strong)UIImageView *topImage;

@property (nonatomic, strong)UIView *whitView;

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) CustomGifHeader *gifHeader;

@property (nonatomic,strong) UIImageView *img_noOpen;

@property (nonatomic,strong) UIButton *btn_noOpen;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) ETChatLishAddfriendModel *friendModel;

@property (nonatomic,strong) ETChatLishAddgroupModel *groupModel;

@property (nonatomic,strong) ETChatLishModel *model;

@property (nonatomic,strong)  UIButton *addressBookBtn;

@property (nonatomic,strong) UIButton *addBtn;

@end

@implementation ETChatViewcontroller

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [self getChatSelusername];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    self.topImage.userInteractionEnabled = YES;
    [self.view addSubview:self.topImage];
    self.dataSource = [NSMutableArray array];
    [self.topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kStatusAndNavHeight + 20);
    }];
    
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"聊天";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [self.topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.topImage.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(iPhoneBang?kStatusBarHeight:(kStatusBarHeight + 10));
        
    }];
    
    self.whitView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusAndNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 80)];
    self.whitView.clipsToBounds = YES;
    self.whitView.layer.cornerRadius = 25;
    self.whitView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.whitView];
     [self notOpenFriends];
    //    [self notOpenFriends];
    
    
}



//- (void)socketLine{
//    ETWalletModel *model1 = [ETWalletManger getCurrentWallet];
//    [[ETSocketHelper sharedSocketHelper] socketRequest:@"http://47.244.50.67:2569" AndKey:@"refresh" success:^(id  _Nonnull responseObject) {
//        ETChatDetailsChatModel *model =[ETChatDetailsChatModel mj_objectWithKeyValues:responseObject];
//        if (![model.togroup isEqualToString:@""]) {
//            [self getChatUserqun:model.togroup];
//        }else{
//            if ([model.towho isEqualToString:model1.address]) {
//                [self getChatinglist];
//            }
//
//        }
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
//}
//
/////判断是否开启聊天
//- (void)getChatSelusername{
//    ETWalletModel *model = [ETWalletManger getCurrentWallet];
//    [HTTPTool requestDotNetWithURLString:@"selusername" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
//         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
//        if (baseModel.code == 200) {
//            [self openFriends];
//            [self socketLine];
//            [self getChatinglist];
//        }else{
//           [self notOpenFriends];
//        }
//    } failure:^(NSError *error) {
//
//    }];
//}
//
//
//
/////注册聊天
//- (void)getChatAddchatuser{
//    ETWalletModel *model = [ETWalletManger getCurrentWallet];
//    [SVProgressHUD showWithStatus:@""];
//    [HTTPTool requestDotNetWithURLString:@"addchatuser" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
//        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
//        //        if (baseModel.code == 200) {
//        ETWalletModel *model = [ETWalletManger getCurrentWallet];
//        model.isOpenChat = YES;
//        [ETWalletManger updateWallet:model];
//        [self openFriends];
//        [self getChatinglist];
//        //        }
//        [KMPProgressHUD showText:baseModel.msg];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
//    }];
//}
//
/////判断是否在群
//- (void)getChatUserqun:(NSString *)qcode{
//    [SVProgressHUD dismiss];
//    ETWalletModel *model = [ETWalletManger getCurrentWallet];
//    [HTTPTool requestDotNetWithURLString:@"user_qun" parameters:@{@"address":model.address,@"qcode":qcode} type:kPOST success:^(id responseObject) {
//        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
//        if (baseModel.code == 200) {
//            [self getChatinglist];
//        }
//
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//
//    }];
//}
//
/////本群消息已读
//- (void)getChatLookgroupchating:(NSString *)qcode{
//    [SVProgressHUD dismiss];
//    ETWalletModel *model = [ETWalletManger getCurrentWallet];
//    [HTTPTool requestDotNetWithURLString:@"lookgroupchating" parameters:@{@"fromwho":model.address,@"qcode":qcode} type:kPOST success:^(id responseObject) {
//        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
//        if (baseModel.code == 200) {
//
//        }
//
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//
//    }];
//}
//
/////本群消息已读
//- (void)getChatLookchating:(NSString *)address{
//    [SVProgressHUD dismiss];
//    ETWalletModel *model = [ETWalletManger getCurrentWallet];
//    [HTTPTool requestDotNetWithURLString:@"lookchating" parameters:@{@"fromwho":model.address,@"towho":address} type:kPOST success:^(id responseObject) {
//        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
//        if (baseModel.code == 200) {
//
//        }
//
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//
//    }];
//}
//
/////新聊天列表
//- (void)getChatinglist{
//    [SVProgressHUD dismiss];
//    ETWalletModel *model = [ETWalletManger getCurrentWallet];
//    //    [SVProgressHUD showWithStatus:@""];
//    [HTTPTool requestDotNetWithURLString:@"chatinglist" parameters:@{@"fromwho":model.address} type:kPOST success:^(id responseObject) {
//        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
//        if (baseModel.code == 200) {
//            [self.dataSource removeAllObjects];
//            self.model =[ETChatLishModel mj_objectWithKeyValues:responseObject];
//            self.friendModel = self.model.data.addfriend;
//            self.groupModel = self.model.data.addgroup;
//            [self.dataSource addObjectsFromArray:self.model.data.chats];
//            [self.detailTab reloadData];
//
//        }
//        //        [KMPProgressHUD showText:baseModel.msg];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
//    }];
//}
//

- (void)notOpenFriends{
    [self.detailTab removeFromSuperview];
    [self.addBtn removeFromSuperview];
    [self.addressBookBtn removeFromSuperview];
    self.img_noOpen = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lt_que"]];
    [self.whitView addSubview:self.img_noOpen];
    WEAK_SELF(self);
    [self.img_noOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        
        STRONG_SELF(self);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(281);
        make.top.equalTo(self.whitView.mas_top).offset(68);
        
    }];
    
    self.btn_noOpen = [[UIButton alloc]init];
    self.btn_noOpen.clipsToBounds = YES;
    self.btn_noOpen.layer.cornerRadius = 5;
    self.btn_noOpen.backgroundColor = UIColorFromHEX(0xEBEBEB, 1);
    [ self.btn_noOpen setTitle:@"暂未开放" forState:UIControlStateNormal];
//    [ self.btn_noOpen addTarget:self action:@selector(actionOfValidation:) forControlEvents:UIControlEventTouchUpInside];
    [ self.btn_noOpen setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.whitView addSubview: self.btn_noOpen];
    [ self.btn_noOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.img_noOpen.mas_bottom).offset(80);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(44);
        
    }];
}

//- (void)openFriends{
//    [self.img_noOpen removeFromSuperview];
//    [self.btn_noOpen removeFromSuperview];
//    [self.whitView addSubview:self.detailTab];
//    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.right.left.mas_equalTo(self.whitView);
//
//    }];
//    self.addressBookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.addressBookBtn setImage:[UIImage imageNamed:@"lt_lianxiren"] forState:UIControlStateNormal];
//    [self.topImage addSubview:self.addressBookBtn];
//    [self.addressBookBtn addTarget:self action:@selector(actionOfAddress:) forControlEvents:UIControlEventTouchUpInside];
//    [self.addressBookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(iPhoneBang?kStatusBarHeight:(kStatusBarHeight + 5));
//        make.left.equalTo(self.view.mas_left).offset(15);
//        make.width.height.offset(30);
//    }];
//
//    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.addBtn setImage:[UIImage imageNamed:@"lt_jia"] forState:UIControlStateNormal];
//    [self.topImage addSubview:self.addBtn];
//    [self.addBtn addTarget:self action:@selector(actionOfAdd:) forControlEvents:UIControlEventTouchUpInside];
//    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(iPhoneBang?kStatusBarHeight:(kStatusBarHeight + 5));
//        make.right.equalTo(self.view.mas_right).offset(-15);
//        make.width.height.offset(30);
//    }];
//
//    [self.detailTab reloadData];
//
//}
//
//#pragma mark - UITableViewDelegate,UITableViewDataSource
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return self.dataSource.count + 2;
//
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    ETChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETChatCell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (indexPath.row == 0) {
//        cell.groupModel = self.groupModel;
//    }else if (indexPath.row == 1) {
//        cell.friendModel = self.friendModel;
//    }else {
//        cell.model = self.dataSource[indexPath.row - 2];
//    }
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        ETCharGroupAndFriendNoticeViewController *vc = [ETCharGroupAndFriendNoticeViewController new];
//        vc.hidesBottomBarWhenPushed = true;
//        vc.flag = NO;
//        [self.navigationController pushViewController:vc animated:true];
//    }else if (indexPath.row == 1) {
//        ETCharGroupAndFriendNoticeViewController *vc = [ETCharGroupAndFriendNoticeViewController new];
//        vc.hidesBottomBarWhenPushed = true;
//        vc.flag = YES;
//        [self.navigationController pushViewController:vc animated:true];
//    }else {
//        ETChatLishcChatsModel *model = self.dataSource[indexPath.row - 2];
//        if ([model.qcode isEqualToString:@""]) {
//            ETChatDetailsViewController *vc = [ETChatDetailsViewController new];
//            vc.toAddress = model.fromwho;
//            vc.name = model.fromwhoname;
//            vc.hidesBottomBarWhenPushed = YES;
//            [self getChatLookchating:model.fromwho];
//            [self.navigationController pushViewController:vc animated:true];
//        }else {
//            [self getChatLookgroupchating:model.qcode];
//            ETChatGroupDetailsViewController *vc = [ETChatGroupDetailsViewController new];
//            vc.qcode = model.qcode;
//            vc.name = model.qname;
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:true];
//
//        }
//
//
//
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.1;
//}
//
//
//#pragma mark - ETAddFriendsPopViewDelegate
/////0创建群聊 1添加好友 2扫一扫
//- (void)ETAddFriendsPopViewDelegate:(NSInteger)tag{
//    if (tag == 0) {
//        ETCreateGroupChatViewController *vc = [ETCreateGroupChatViewController new];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:true];
//    }else if (tag == 1) {
//        ETAddFriendsViewController *vc = [ETAddFriendsViewController new];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:true];
//    }else if (tag == 2){
//        ETScanViewController *cVC = [ETScanViewController new];
//        cVC.isDirection = YES;
//        cVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:cVC animated:YES];
//    }
//
//}
//
//
//- (UITableView *)detailTab {
//
//    if (!_detailTab) {
//        _detailTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _detailTab.delegate = self;
//        _detailTab.dataSource = self;
//        //        _detailTab.clipsToBounds = YES;
//        //        _detailTab.layer.cornerRadius = 26;
//        //        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_detailTab registerNib:[UINib nibWithNibName:@"ETChatCell" bundle:nil] forCellReuseIdentifier:@"ETChatCell"];
//
//        _detailTab.mj_header = self.gifHeader;
//    }
//    return _detailTab;
//}
//
//- (CustomGifHeader *)gifHeader {
//    if (!_gifHeader) {
//        WEAK_SELF(self);
//        _gifHeader = [CustomGifHeader headerWithRefreshingBlock:^{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                STRONG_SELF(self);
//                [self.detailTab.mj_header endRefreshing];
//                [self getChatinglist];
//            });
//        }];
//    }
//    return _gifHeader;
//}
//
//
/////开启好友验证
//- (void)actionOfValidation:(UIButton *)btn{
//    WEAK_SELF(self);
//    ETVerifyPassWrodView *view = [[ETVerifyPassWrodView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [view setSuccess:^{
//        [weak_self.btn_noOpen removeFromSuperview];
//        [weak_self.img_noOpen removeFromSuperview];
//        [weak_self getChatAddchatuser];
//
//    }];
//    [[UIApplication sharedApplication].keyWindow addSubview:view];
//}
//
/////通讯录
//- (void)actionOfAddress:(UIButton *)btn{
//    ETAddressBookViewController *vc = [ETAddressBookViewController new];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:true];
//}
//
/////加好友
//- (void)actionOfAdd:(UIButton *)btn{
//    ETAddFriendsPopView *addPop = [[ETAddFriendsPopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    addPop.delegate = self;
//    [addPop show];
//}


@end
