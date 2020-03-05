//
//  ETGroupMembersViewController.m
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETGroupMembersViewController.h"
#import "ETGroupMembersCell.h"
#import "ETGroupMembersModel.h"
@interface ETGroupMembersViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITextField *tf_seach;
@property (nonatomic,strong)ETGroupMembersModel *model;
@end

@implementation ETGroupMembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群成员";
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"ETGroupMembersCell" bundle:nil] forCellReuseIdentifier:@"ETGroupMembersCell"];
    [self getChatGroupusers];
    // Do any additional setup after loading the view from its nib.
}

- (void)getChatGroupusers{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"groupusers" parameters:@{@"address":model.address,@"qcode":self.qcode}    type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.model =[ETGroupMembersModel mj_objectWithKeyValues:responseObject];
            [self.dataSource addObjectsFromArray:self.model.data];
            [self.tableView reloadData];
        }
        [KMPProgressHUD showText:baseModel.msg];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

///搜索
- (IBAction)actionOfSearchChanged:(UITextField *)sender {
  
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETGroupMembersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETGroupMembersCell"];
        cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.lab_num.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
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
