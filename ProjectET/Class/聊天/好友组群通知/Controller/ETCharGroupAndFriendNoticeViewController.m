//
//  ETCharGroupAndFriendNoticeViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETCharGroupAndFriendNoticeViewController.h"
#import "ETCharGroupAndFriendNoticeCell.h"
#import "ETCharGroupAndFriendNoticeModel.h"

@interface ETCharGroupAndFriendNoticeViewController ()<ETCharGroupAndFriendNoticeDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)ETCharGroupAndFriendNoticeModel *model;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic,strong) CustomGifHeader *gifHeader;
@end

@implementation ETCharGroupAndFriendNoticeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.currentPage = 0;
    if (self.flag) {
        [self getChatFriendlist];
    }else {
        [self getChatGroupaddlist];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.flag) {
        self.title = @"好友通知";
    }else {
        self.title = @"群通知";
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"ETCharGroupAndFriendNoticeCell" bundle:nil] forCellReuseIdentifier:@"ETCharGroupAndFriendNoticeCell"];
    self.dataSource = [NSMutableArray array];
    WEAK_SELF(self);
    self.tableView.mj_header = self.gifHeader;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        STRONG_SELF(self);
        [self.tableView.mj_footer endRefreshing];
        self.currentPage += 1;
        if (self.flag) {
            [self getChatFriendlist];
        }else {
            [self getChatGroupaddlist];
        }
        
    }];
    // Do any additional setup after loading the view from its nib.
}

///群申请列表
- (void)getChatGroupaddlist{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"groupaddlist" parameters:@{@"fromwho":model.address,@"page":[NSString stringWithFormat:@"%ld",(long)self.currentPage]}    type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            if (self.currentPage == 0) {
                [self.dataSource removeAllObjects];
            }
            self.model =[ETCharGroupAndFriendNoticeModel mj_objectWithKeyValues:responseObject];
            [self.dataSource addObjectsFromArray:self.model.data.list];
            [self.tableView reloadData];
        }
        [KMPProgressHUD showText:baseModel.msg];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

///好友列表
- (void)getChatFriendlist{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"friendlist" parameters:@{@"fromwho":model.address,@"page":[NSString stringWithFormat:@"%ld",(long)self.currentPage]}    type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        
        if (baseModel.code == 200) {
            if (self.currentPage == 0) {
                [self.dataSource removeAllObjects];
            }
            self.model =[ETCharGroupAndFriendNoticeModel mj_objectWithKeyValues:responseObject];
            [self.dataSource addObjectsFromArray:self.model.data.list];
            [self.tableView reloadData];
        }
        [KMPProgressHUD showText:baseModel.msg];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}


///好友通过驳回
- (void)getChatAddchatfriend:(NSString *)api AndId:(NSString *)Id{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    
    [HTTPTool requestDotNetWithURLString:api parameters:@{@"fromwho":model.address,@"fid":Id}    type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        [self.dataSource removeAllObjects];
        if (baseModel.code == 200) {
            [self getChatFriendlist];
        }
        [KMPProgressHUD showText:baseModel.msg];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

///群组通过驳回
- (void)getChatAdminaddgroup:(NSString *)state AndId:(NSString *)Id AndQCode:(NSString *)qcode{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"adminaddgroup" parameters:@{@"address":model.address,@"sid":Id,@"qcode":qcode,@"state":state}    type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        [self.dataSource removeAllObjects];
        if (baseModel.code == 200) {
            [self getChatGroupaddlist];
        }
        [KMPProgressHUD showText:baseModel.msg];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETCharGroupAndFriendNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCharGroupAndFriendNoticeCell"];
    cell.delegate = self;
    if (self.flag) {
        cell.friendModel = self.dataSource[indexPath.row];
    }else {
        cell.groupModel = self.dataSource[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (CustomGifHeader *)gifHeader {
    if (!_gifHeader) {
        WEAK_SELF(self);
        _gifHeader = [CustomGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                STRONG_SELF(self);
                self.currentPage = 0;
                [self.tableView.mj_header endRefreshing];
                if (self.flag) {
                    [self getChatFriendlist];
                }else {
                    [self getChatGroupaddlist];
                }
            });
        }];
    }
    return _gifHeader;
}

#pragma mark - ETCharGroupAndFriendNoticeDelegate

-(void)ETCharGroupAndFriendNoticeAgreeDelegate:(NSString *)Id AndQCode:(nonnull NSString *)qcode{
    if (self.flag) {
        [self getChatAddchatfriend:@"addchatfriend_ok" AndId:Id];
    }else {
        [self getChatAdminaddgroup:@"2" AndId:Id AndQCode:qcode];
    }
}


-(void)ETCharGroupAndFriendNoticeRefusedDelegate:(NSString *)Id AndQCode:(nonnull NSString *)qcode{
    if (self.flag) {
        [self getChatAddchatfriend:@"addchatfriend_no" AndId:Id];
    }else {
         [self getChatAdminaddgroup:@"3" AndId:Id AndQCode:qcode];
    }
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
