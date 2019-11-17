//
//  ETNewAlertsViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewAlertsViewController.h"
#import "ETNewAlertsDetailsViewController.h"
#import "ETNewAlertsCell.h"
#import "ETNewAlertsModel.h"

@interface ETNewAlertsViewController ()<UITableViewDelegate,UITableViewDataSource,ETNewAlertsCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong)ETNewAlertsModel *model;
@property (nonatomic, assign)NSInteger currentPage;


@end

@implementation ETNewAlertsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
    self.lab_time.text = [Tools dateToString:NSDate.date];
    self.dataSource  = [NSMutableArray array];
    self.currentPage = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"ETNewAlertsCell" bundle:nil] forCellReuseIdentifier:@"ETNewAlertsCell"];
     WEAK_SELF(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONG_SELF(self);
        self.currentPage = 0;
        [self.tableView.mj_header endRefreshing];
        [self getAlertsListData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        STRONG_SELF(self);
        [self.tableView.mj_footer endRefreshing];
        self.currentPage += 1;
        [self getAlertsListData];
    }];
    
    [self getAlertsListData];
    self.tableView.estimatedRowHeight = 1000;
    // Do any additional setup after loading the view from its nib.
}


- (void)getAlertsListData{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"et_newsflash" parameters:@{@"page":[NSString stringWithFormat:@"%ld",(long)self.currentPage]}    type:kPOST success:^(id responseObject) {
        if (self.currentPage == 0) {
            [self.dataSource removeAllObjects];
        }
        
        NSLog(@"%@",responseObject);
        self.model =[ETNewAlertsModel mj_objectWithKeyValues:responseObject];
        [self.dataSource addObjectsFromArray:self.model.data.News];
        for (ETNewConalertNewsListData *model in self.dataSource) {
            model.islook = @"0";
        }
        [self.tableView reloadData];
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

    ETNewAlertsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETNewAlertsCell"];
    cell.model = self.dataSource[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ETNewConalertNewsListData *model = self.dataSource[indexPath.row];
    if ([model.islook isEqual:@"0"]) {
        model.islook = @"1";
    }else {
        model.islook = @"0";
    }
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - ETNewAlertsCellDelegate

-(void)ETNewAlertsCellDelegateWithShare:(ETNewConalertNewsListData *)model{
    ETNewAlertsDetailsViewController *vc = [[ETNewAlertsDetailsViewController alloc]init];
    vc.titleStr = model.title;
    vc.time = model.time;
    vc.source = model.source;
    vc.content = model.content;
    vc.url = model.url;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:true];
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
