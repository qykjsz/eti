//
//  ETMyContactsController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETMyContactsController.h"
#import "ETAddContactsController.h"

#import "ETMyContactsCell.h"
#import "ETMycontactListModel.h"

@interface ETMyContactsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) ETMycontactListModel *model;

@end

@implementation ETMyContactsController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self listRequest];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"联系人";
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    
}

#pragma mark - NET

- (void)listRequest {
    
    NSUUID *uuid = [UIDevice currentDevice].identifierForVendor;
    [HTTPTool requestDotNetWithURLString:@"et_contactsall" parameters:@{@"contacts":uuid.UUIDString} type:kPOST success:^(id responseObject) {
        
        self.model = [ETMycontactListModel mj_objectWithKeyValues:responseObject];
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.model.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETMyContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETMyContactsCell"];
    contactData *data = self.model.data[indexPath.row];
    cell.nameLb.text = data.name;
    [cell.walletTypeBtn setTitle:data.wallettype forState:UIControlStateNormal];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (UIView *)footerView{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 44)];
    btn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    [btn setTitle:@"新建联系人" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    return backView;
    
}


- (void)clickAction {
    
    ETAddContactsController *addVC = [ETAddContactsController new];
    [self.navigationController pushViewController:addVC animated:YES];
    
}


#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETMyContactsCell" bundle:nil] forCellReuseIdentifier:@"ETMyContactsCell"];
        _detailTab.tableFooterView = [self footerView];
    }
    return _detailTab;
}

@end
