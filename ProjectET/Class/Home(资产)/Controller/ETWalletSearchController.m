//
//  ETWalletSearchController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETWalletSearchController.h"
#import "ETWalletSearchCell.h"

#import "ETPlatformGlodModel.h"

@interface ETWalletSearchController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) ETPlatformGlodModel *model;

@property (nonatomic,strong) UITextField *textfiled;

@property (nonatomic,strong) UIView *lineView;

@end

@implementation ETWalletSearchController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self platformGlodRequest];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self pageLayout];
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.detailTab];
    WEAK_SELF(self);
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        STRONG_SELF(self);
        make.top.equalTo(self.lineView.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
}

#pragma mark - NET
- (void)platformGlodRequest {
    
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    
    [HTTPTool requestDotNetWithURLString:@"et_platformglod" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
        
        [self.dataArray removeAllObjects];
        self.model = [ETPlatformGlodModel mj_objectWithKeyValues:responseObject];
        [self.dataArray addObjectsFromArray:self.model.data];
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETWalletSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETWalletSearchCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ETPlatformGlodData *data = self.dataArray[indexPath.row];
    
    NSString *status = nil;
    if ([data.have isEqualToString:@"1"]) {
        status = @"2";
    }else {
        status = @"1";
    }
    ETWalletModel *wModel = [ETWalletManger getCurrentWallet];
    
    [HTTPTool requestDotNetWithURLString:@"et_glodoperation" parameters:@{@"address":wModel.address,@"glodid":data.Id,@"operationtype":status} type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self platformGlodRequest];
        [self.detailTab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)pageLayout {
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchView];
    
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [cancelBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(searchView.mas_top).offset(kStatusBarHeight);
        make.right.equalTo(searchView.mas_right).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
        
    }];
    
    self.textfiled = [[UITextField alloc]init];
    self.textfiled.clipsToBounds = YES;
    self.textfiled.layer.cornerRadius = 12;
    self.textfiled.backgroundColor = UIColorFromHEX(0xf5f5f5, 1);
    self.textfiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索代币名称/合约/项目名称" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:12]}];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 30)];
    UIImageView *imag = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zc_sousuo"]];
    imag.frame = CGRectMake(10, 8, 14, 15);
    [backView addSubview:imag];
    self.textfiled.leftView = backView;
    self.textfiled.leftViewMode = UITextFieldViewModeAlways;
    [searchView addSubview:self.textfiled];
    [self.textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(searchView.mas_left).offset(15);
        make.centerY.equalTo(cancelBtn.mas_centerY);
        make.right.equalTo(searchView.mas_right).offset(-55);
        make.height.mas_equalTo(24);
        
    }];
    
    [self.textfiled addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = UIColorFromHEX(0xEBEBEB, 1);
    [searchView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(searchView);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.textfiled.mas_bottom).offset(10);
        
    }];
}

#pragma mark - Atcion
- (void)cancleAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)textfieldDidChange:(UITextField *)textfiled {
    
    [self.dataArray removeAllObjects];
    for (ETPlatformGlodData *data in self.model.data) {
        if ([data.name isEqualToString:[textfiled.text uppercaseString]]) {
            [self.dataArray addObject:data];
        }
    }
    
    if ([Tools checkStringIsEmpty:textfiled.text]) {
        [self.dataArray addObjectsFromArray:self.model.data];
    }
    
    [self.detailTab reloadData];
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETWalletSearchCell class] forCellReuseIdentifier:@"ETWalletSearchCell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
    }
    return _detailTab;
}




@end
