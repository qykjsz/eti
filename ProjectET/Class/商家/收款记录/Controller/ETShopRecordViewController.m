//
//  ETShopRecordViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETShopRecordViewController.h"
#import "ETShopRecordCell.h"
#import "ETShopRecordModel.h"
@interface ETShopRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger curretnPage;
@property (nonatomic,strong)ETShopRecordModel *model;
@end

@implementation ETShopRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款记录";
    self.dataSource = [NSMutableArray array];
    self.view.backgroundColor = UIColor.whiteColor;
    self.curretnPage = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"ETShopRecordCell" bundle:nil] forCellReuseIdentifier:@"ETShopRecordCell"];
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
    // Do any additional setup after loading the view from its nib.po
}

- (void)getAlertsListData{
    [SVProgressHUD showWithStatus:@""];
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"api_shoporder" parameters:@{@"page":[NSString stringWithFormat:@"%ld",(long)self.curretnPage],@"address":model.address}    type:kPOST success:^(id responseObject) {
        if (self.curretnPage == 0) {
            [self.dataSource removeAllObjects];
    
        }

        NSLog(@"%@",responseObject);
        self.model =[ETShopRecordModel mj_objectWithKeyValues:responseObject];
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

    return 82;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETShopRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETShopRecordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
