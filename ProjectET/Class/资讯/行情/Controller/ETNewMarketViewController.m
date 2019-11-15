//
//  ETNewMarketViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewMarketViewController.h"
#import "ETNewMarketModel.h"
#import "ETNewMarketCell.h"

@interface ETNewMarketViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong)ETNewMarketModel *model;


@end

@implementation ETNewMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
    self.dataSource  = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"ETNewMarketCell" bundle:nil] forCellReuseIdentifier:@"ETNewMarketCell"];
    WEAK_SELF(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONG_SELF(self);
        [self.tableView.mj_header endRefreshing];
        [self getAlertsListData];
    }];

    [self getAlertsListData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getAlertsListData{
    [HTTPTool requestDotNetWithURLString:@"et_quotation" parameters:@{@"":@""}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.dataSource removeAllObjects];
        self.model =[ETNewMarketModel mj_objectWithKeyValues:responseObject];
        [self.dataSource addObjectsFromArray:self.model.data];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETNewMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETNewMarketCell"];
    cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
