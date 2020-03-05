//
//  ETNewChatNewFriendViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatNewFriendViewController.h"
#import "ETNewChatNewFriendCell.h"
#import "ETNewChatNewFriendModel.h"

@interface ETNewChatNewFriendViewController ()<ETNewChatNewFriendCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic,strong)ETNewChatNewFriendModel *model;

@end

@implementation ETNewChatNewFriendViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getChatGroupusers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新朋友";
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"ETNewChatNewFriendCell" bundle:nil] forCellReuseIdentifier:@"ETNewChatNewFriendCell"];
    
    // Do any additional setup after loading the view from its nib.
}

///好友列表
- (void)getChatGroupusers{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_givefriend" parameters:@{@"uid":model.ryID} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        [self.dataSource removeAllObjects];
        if (baseModel.code == 200) {
            self.model =[ETNewChatNewFriendModel mj_objectWithKeyValues:responseObject];
            [self.dataSource addObjectsFromArray:self.model.data];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.dataSource removeAllObjects];
        [self.tableView reloadData];
    }];
}


///好友列表
- (void)getRongyunAddfriendAgree:(NSString *)tid AndStatus:(NSString *)status{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_addfriend_agree" parameters:@{@"uid":model.ryID,@"tid":tid,@"status":status} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            [self getChatGroupusers];
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.dataSource removeAllObjects];
        [self.tableView reloadData];
    }];
}


#pragma mark - ETNewChatNewFriendCellDelegate

///同意
- (void)ETNewChatNewFriendCellAgreeDelegate:(NSString *)uid{
    [self getRongyunAddfriendAgree:uid AndStatus:@"1"];
}

///拒绝
- (void)ETNewChatNewFriendCellCancelDelegate:(NSString *)uid{
    [self getRongyunAddfriendAgree:uid AndStatus:@"2"];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETNewChatNewFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETNewChatNewFriendCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
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
