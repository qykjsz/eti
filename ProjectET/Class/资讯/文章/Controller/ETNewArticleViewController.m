//
//  ETNewArticleViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewArticleViewController.h"
#import "ETNewArticleModel.h"
#import "ETNewArticleCell.h"
#import "ETNewArticleDetailsViewController.h"

@interface ETNewArticleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic,strong)ETNewArticleModel *model;
@property (nonatomic,strong) CustomGifHeader *gifHeader;
@end

@implementation ETNewArticleViewController
- (CustomGifHeader *)gifHeader {
    if (!_gifHeader) {
        _gifHeader = [CustomGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   self.currentPage = 0;
                   [self.tableView.mj_header endRefreshing];
                   [self getAlertsListData];
            });
        }];
    }
    return _gifHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
      self.lab_time.text = [Tools dateToCNString:NSDate.date];
    self.dataSource  = [NSMutableArray array];
    self.currentPage = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"ETNewArticleCell" bundle:nil] forCellReuseIdentifier:@"ETNewArticleCell"];
    WEAK_SELF(self);
    self.tableView.mj_header = self.gifHeader;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        STRONG_SELF(self);
        [self.tableView.mj_footer endRefreshing];
        self.currentPage += 1;
        [self getAlertsListData];
    }];
    
    [self getAlertsListData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getAlertsListData{
     [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"et_news" parameters:@{@"page":[NSString stringWithFormat:@"%ld",(long)self.currentPage]}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if (self.currentPage == 0) {
            [self.dataSource removeAllObjects];
              self.lab_time.text = [Tools dateToCNString:NSDate.date];
        }
        self.model =[ETNewArticleModel mj_objectWithKeyValues:responseObject];
        [self.dataSource addObjectsFromArray:self.model.data.News];
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
    
    ETNewArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETNewArticleCell"];
    cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ETNewArticleDetailsViewController *vc = [[ETNewArticleDetailsViewController alloc]init];
    vc.Id = [self.dataSource[indexPath.row] Id];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:true];
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
