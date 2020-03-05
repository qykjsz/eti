//
//  ETNewChatMineGroupViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatMineGroupViewController.h"
#import "ETNewChatMineGroupCell.h"
#import "ETNewChatMineGroupModel.h"
#import "ETNewChatDetailsViewController.h"

@interface ETNewChatMineGroupViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic,strong)ETNewChatMineGroupModel *model;

@end

@implementation ETNewChatMineGroupViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getChatGroupusers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的群组";
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"ETNewChatMineGroupCell" bundle:nil] forCellReuseIdentifier:@"ETNewChatMineGroupCell"];
  
    // Do any additional setup after loading the view from its nib.
}

///好友列表
- (void)getChatGroupusers{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
     [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_mygroups" parameters:@{@"uid":model.ryID} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        [self.dataSource removeAllObjects];
        if (baseModel.code == 200) {
            self.model =[ETNewChatMineGroupModel mj_objectWithKeyValues:responseObject];
            [self.dataSource addObjectsFromArray:self.model.data];
            for (ETNewChatMineGroupDataModel *data in self.model.data) {
                if ([data.number isEqualToString:@"0"]) {
                    [self getrongyunDelgropuser:data.ID];
                    [self.dataSource removeObject:data];
                }
            }
             [SVProgressHUD dismiss];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
         [SVProgressHUD dismiss];
        [self.dataSource removeAllObjects];
        [self.tableView reloadData];
    }];
}


///移除群成员
- (void)getrongyunDelgropuser:(NSString *)qid{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_delmygroups" parameters:@{@"uid":model.ryID,@"qid":qid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            
        }
  
    
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
    
    ETNewChatMineGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETNewChatMineGroupCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ETNewChatMineGroupDataModel *model = self.dataSource[indexPath.row];
     ETNewChatDetailsViewController *conversationVC = [[ETNewChatDetailsViewController alloc]initWithConversationType:ConversationType_GROUP targetId:model.ID];
        conversationVC.title = @"聊天";
        conversationVC.fromGroupType = @"1";
        [self.navigationController pushViewController:conversationVC animated:true];

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
