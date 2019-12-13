//
//  ETTopupCenterRecordViewController.m
//  ProjectET
//
//  Created by mac on 2019/12/9.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTopupCenterRecordViewController.h"
#import "ETTopupCenterRecordCell.h"
#import "ETTopupCenterRecordModel.h"

@interface ETTopupCenterRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger curretnPage;
@property (nonatomic,strong)ETTopupCenterRecordModel *model;

@end

@implementation ETTopupCenterRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值记录";
    self.dataSource = [NSMutableArray array];
    self.view.backgroundColor = UIColor.whiteColor;
    self.curretnPage = 0;
     [self.tableView registerNib:[UINib nibWithNibName:@"ETTopupCenterRecordCell" bundle:nil] forCellReuseIdentifier:@"ETTopupCenterRecordCell"];
    WEAK_SELF(self);
       self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
              STRONG_SELF(self);
               self.curretnPage = 0;
              [self.tableView.mj_header endRefreshing];
              [self getAlertsListData];
          }];
          
          self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
              
              STRONG_SELF(self);
              [self.tableView.mj_footer endRefreshing];
              self.curretnPage += 1;
              [self getAlertsListData];
          }];
          
          [self getAlertsListData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getAlertsListData{
    [SVProgressHUD showWithStatus:@""];
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"recharge_et_gameorder" parameters:@{@"page":[NSString stringWithFormat:@"%ld",(long)self.curretnPage],@"address":model.address}    type:kPOST success:^(id responseObject) {
        if (self.curretnPage == 0) {
            [self.dataSource removeAllObjects];
    
        }
        NSLog(@"%@",responseObject);
        self.model =[ETTopupCenterRecordModel mj_objectWithKeyValues:responseObject];
        [self.dataSource addObjectsFromArray:self.model.data.order];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark--------DELEGATE-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 85;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETTopupCenterRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETTopupCenterRecordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
