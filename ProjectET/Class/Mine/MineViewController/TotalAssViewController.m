//
//  TotalAssViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "TotalAssViewController.h"
#import "ETWalletDetailView.h"
#import "TotalCell.h"

@interface TotalAssViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSString *walletName;

@end

@implementation TotalAssViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        
    }];
    
    UIButton *popBtn = [[UIButton alloc]init];
    [popBtn setImage:[UIImage imageNamed:@"fh_icon_white"] forState:UIControlStateNormal];
    [popBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [popBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [popBtn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:popBtn];
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImage.mas_top).offset(20);
        make.width.height.equalTo(@44);
        
    }];
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"资产总览";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.centerY.equalTo(popBtn.mas_centerY);
        
    }];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    [arr addObject:@"0.03"];
    [arr addObject:@"0.06"];
    [arr addObject:@"0.11"];
    [arr addObject:@"0.8"];
    
    
//    ETWalletDetailView *headerView = [[ETWalletDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280) andProgress:arr];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
    headerView.clipsToBounds = YES;
    headerView.layer.cornerRadius = 25;
    UITextField *field = [[UITextField alloc]init];
//                          WithFrame:CGRectMake(15, 230, SCREEN_WIDTH-30, 30)];
    field.placeholder = @"搜索";
    field.backgroundColor = [UIColor grayColor];
    field.font = [UIFont systemFontOfSize:14];
    field.layer.borderWidth = .5;
    field.layer.masksToBounds = YES;
    field.layer.cornerRadius = 15;
    [field setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    field.layer.borderColor = [[UIColor whiteColor] CGColor];
    field.leftViewMode = UITextFieldViewModeAlways;
    field.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 10)];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, -3, 16, 18)];
    icon.image = [UIImage imageNamed:@"fx_spusuo"];
    [field.leftView addSubview:icon];
    [headerView addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.top.equalTo(headerView.mas_bottom).offset(-30);
        make.height.mas_offset(30);
    }];
    
    [self.view addSubview:self.detailTab];
//    self.detailTab.tableHeaderView = headerView;
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(topImage.mas_bottom).offset(-20);
        make.left.right.bottom.equalTo(self.view);

    }];
}
- (void)popAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETWalletDetailCell" bundle:nil] forCellReuseIdentifier:@"ETWalletDetailCell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
    }
    return _detailTab;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    //单元格ID
    //重用单元格
    TotalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[TotalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
//    UIView *line = [ClassBaseTools viewWithBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.3]];
//    [cell.contentView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(15);
//        make.bottom.equalTo(cell.contentView.mas_bottom);
//        make.width.mas_offset(SCREEN_WIDTH);
//        make.height.mas_offset(.5);
//    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
