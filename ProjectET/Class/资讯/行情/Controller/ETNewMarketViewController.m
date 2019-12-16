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
#import "ETNewTwoMarketCell.h"

@interface ETNewMarketViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong)ETNewMarketModel *model;
@property (nonatomic,strong)NSString *sort;
@property (nonatomic,strong) CustomGifHeader *gifHeader;

@end

@implementation ETNewMarketViewController

- (CustomGifHeader *)gifHeader {
    if (!_gifHeader) {
        WEAK_SELF(self);
        _gifHeader = [CustomGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                STRONG_SELF(self);
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
    self.dataSource  = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"ETNewTwoMarketCell" bundle:nil] forCellReuseIdentifier:@"ETNewTwoMarketCell"];
    self.tableView.mj_header = self.gifHeader;
    [self getAlertsListData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getAlertsListData{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"et_quotation" parameters:@{@"":@""}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.dataSource removeAllObjects];
        self.model =[ETNewMarketModel mj_objectWithKeyValues:responseObject];
        [self.dataSource addObjectsFromArray:self.model.data];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}


- (void)getAlertsSortData{
    NSMutableArray *arr = [NSMutableArray array];
    for (ETNewMarketDatasModel *model in self.dataSource){
        NSDictionary *dic = @{@"name":model.name};
        [arr addObject:dic];
    }
    
    NSLog(@"%@",arr);
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"et_quotationsort" parameters:@{@"allglods":arr,@"sort":self.sort}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.dataSource removeAllObjects];
        self.model =[ETNewMarketModel mj_objectWithKeyValues:responseObject];
        [self.dataSource addObjectsFromArray:self.model.data];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

/////最新价
//- (IBAction)actionOfNew:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    if (sender.isSelected) {
//        self.sort = @"1";
//        self.img_new.image = [UIImage imageNamed:@"hq_xjian_01-1"];
//    }else {
//        self.sort = @"2";
//        self.img_new.image = [UIImage imageNamed:@"hq_sjian-1"];
//    }
//    [self getAlertsSortData];
//}
//
//
//- (IBAction)actionOfUp:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    if (sender.isSelected) {
//        self.sort = @"3";
//       self.img_up.image = [UIImage imageNamed:@"hq_xjian_01-1"];
//    }else {
//        self.sort = @"4";
////        self.img_up.image = [UIImage imageNamed:@"hq_xjian_01-1"];
//        self.img_up.image = [UIImage imageNamed:@"hq_sjian-1"];
//    }
//    [self getAlertsSortData];
//}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETNewTwoMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETNewTwoMarketCell"];
    cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab_num.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
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
