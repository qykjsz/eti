//
//  ETMyContactsController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETMyContactsController.h"
#import "ETAddContactsController.h"
#import "ETDirectTransferController.h"
#import "ETContactsTableView.h"
#import "ETMyContactsCell.h"
#import "ETMycontactListModel.h"
#import "UUID.h"

@interface ETMyContactsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) ETContactsTableView *detailTab;

@property (nonatomic,strong) ETMycontactListModel *model;
@property (nonatomic,strong) CustomGifHeader *gifHeader;

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
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.detailTab];
    
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-74);
        //        make.edges.equalTo(self.view);
        
    }];
    [self footerView];
}

#pragma mark - NET

- (void)listRequest {
    
    NSString *uuid = [UUID getUUID];
    [HTTPTool requestDotNetWithURLString:@"et_contactsall" parameters:@{@"contacts":uuid} type:kPOST success:^(id responseObject) {
        
        self.model = [ETMycontactListModel mj_objectWithKeyValues:responseObject];
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}


#pragma mark - NET

- (void)delRequest:(NSString *)name {
    
    NSString *uuid = [UUID getUUID];
    [HTTPTool requestDotNetWithURLString:@"et_delcontacts" parameters:@{@"contacts":uuid,@"contactsid":name} type:kPOST success:^(id responseObject) {
        [KMPProgressHUD showText:@"删除成功"];
        [self listRequest];
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
    contactData *data = self.model.data[indexPath.row];
    if (self.addressBlcok) {
        self.addressBlcok(data.address);
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        ETDirectTransferController *dVC = [ETDirectTransferController new];
        dVC.address = data.address;
        dVC.coinNameString = @"ETH";
        [self.navigationController pushViewController:dVC animated:YES];
        
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (@available(iOS 11.0, *)) {
        UIContextualAction *del = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            contactData *data = self.model.data[indexPath.row];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"确定要删除%@吗？",data.name] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *delAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self delRequest:data.ID];
            }];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:okAction];
            [alertController addAction:delAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }];
        del.backgroundColor = UIColorFromHEX(0xF7FAFF, 1);
        [del setImage:[UIImage imageNamed:@"lxr_sc_icon"]];
        
        UIContextualAction *edit = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            ETAddContactsController *addVC = [ETAddContactsController new];
            addVC.model = self.model.data[indexPath.row];
            [self.navigationController pushViewController:addVC animated:YES];
        }];
        edit.backgroundColor = UIColorFromHEX(0xF7FAFF, 1);
        [edit setImage:[UIImage imageNamed:@"lxg_bj_icon"]];
        
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[del,edit]];
        config.performsFirstActionWithFullSwipe = NO;
        return config;
    } else {
        // Fallback on earlier versions
        return nil;
    }
    
}


- (UIButton *)footerView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    [btn setTitle:@"新建联系人" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-20);
        make.height.offset(44);
        
    }];
    return btn;
}


- (void)clickAction {
    
    ETAddContactsController *addVC = [ETAddContactsController new];
    [self.navigationController pushViewController:addVC animated:YES];
    
}


#pragma mark - lazy load
- (ETContactsTableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[ETContactsTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETMyContactsCell" bundle:nil] forCellReuseIdentifier:@"ETMyContactsCell"];
        //        _detailTab.tableFooterView = [self footerView];
        WEAK_SELF(self);
        _detailTab.mj_header = self.gifHeader;
    }
    return _detailTab;
}

- (CustomGifHeader *)gifHeader {
    if (!_gifHeader) {
    WEAK_SELF(self);
        _gifHeader = [CustomGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STRONG_SELF(self);
                [self.detailTab.mj_header endRefreshing];
                [self listRequest];
            });
        }];
    }
    return _gifHeader;
}

@end
