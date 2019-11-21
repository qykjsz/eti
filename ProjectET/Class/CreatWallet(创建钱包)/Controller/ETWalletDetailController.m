//
//  ETWalletDetailController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETWalletDetailController.h"
#import "ETWalletDetailView.h"
#import "ETWalletDetailCell.h"
#import "ETImportSyaoController.h"
#import "ETKeystoreImportController.h"
#import "ETChangePassWordController.h"
#import "ETVerifyPassWrodView.h"

#import "ETHomeModel.h"

@interface ETWalletDetailController ()<UITableViewDelegate,UITableViewDataSource,ETWalletDetailViewDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSString *walletName;

@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,strong) ETHomeModel *homeModel;

@property (nonatomic,strong) ETWalletDetailView *headerView;

@end

@implementation ETWalletDetailController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}

#pragma mark - NET

- (void)homeRequest {
    //     ETWalletModel *model1 = [ETWalletManger getCurrentWallet];
    //    [HTTPTool requestDotNetWithURLString:@"et_import" parameters:@{@"address":model1.address} type:kPOST success:^(id responseObject) {
    //        NSLog(@"%@",responseObject);
    //    } failure:^(NSError *error) {
    //        NSLog(@"%@",error);
    //    }];
    //    return;
    
    ETWalletModel *model = [ETWalletManger getModelIndex:self.selectWallect];
    [HTTPTool requestDotNetWithURLString:@"et_home" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
        [SVProgressHUD dismiss];
       
        self.homeModel = [ETHomeModel mj_objectWithKeyValues:responseObject];
        
        NSLog(@"%@",responseObject);
        
        
        self.headerView = [[ETWalletDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) andProgress:self.homeModel.data.proportion];
        self.headerView.delegate = self;
        self.headerView.clipsToBounds = YES;
        self.headerView.layer.cornerRadius = 25;
        self.detailTab.tableHeaderView = self.headerView;
        self.headerView.clipsToBounds = YES;
        self.headerView.layer.cornerRadius = 25;
        self.detailTab.tableHeaderView = self.headerView;
        self.headerView.moneyLb.text = self.homeModel.data.allnumber;
        if ([self.homeModel.data.today floatValue] >= 0) {
            self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 +%@",self.homeModel.data.today];
        }else {
            self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 %@",self.homeModel.data.today];
        }
        
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ETWalletModel *model = [ETWalletManger getModelIndex:self.selectWallect];
    self.walletName = model.walletName;
    self.title = model.walletName;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kStatusAndNavHeight + 20);
        
    }];
    
    UIButton *popBtn = [[UIButton alloc]init];
    [popBtn setImage:[UIImage imageNamed:@"fh_icon_white"] forState:UIControlStateNormal];
    [popBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [popBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [popBtn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:popBtn];
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImage.mas_top).offset(kStatusBarHeight);
        make.width.height.equalTo(@44);
        
    }];
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = model.walletName;
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.centerY.equalTo(popBtn.mas_centerY);
        
    }];
    
   
    
  
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(kStatusAndNavHeight);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
    UIButton *dele = [[UIButton alloc] init];
    [dele setTitle:@"删除钱包" forState:UIControlStateNormal];
    [dele setTitleColor:UIColorFromHEX(0xE04159, 1) forState:UIControlStateNormal];
    dele.backgroundColor = UIColorFromHEX(0xf2f2f2, 1);
    dele.titleLabel.font = [UIFont systemFontOfSize:16];
    [dele addTarget:self action:@selector(deleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dele];
    [dele mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithStatus:@"正在加载"];
    });
   
    [self homeRequest];
    
}


- (void)popAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)deleAction {
    ETVerifyPassWrodView *view = [[ETVerifyPassWrodView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [view setSuccess:^{
        ETWalletModel *model = [ETWalletManger getCurrentWallet];
           [ETWalletManger deleWallet:model];
           
           [KMPProgressHUD showText:@"删除成功"];
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
           });
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

#pragma mark - ETWalletDetailViewDelegate
- (void)ETWalletDetailViewDelegateHidden:(BOOL)isOpen {
    
    if (isOpen) {
        self.headerView.moneyLb.text = self.homeModel.data.allnumber;
        if ([self.homeModel.data.today floatValue] >= 0) {
            self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 +%@",self.homeModel.data.today];
        }else {
            self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 %@",self.homeModel.data.today];
        }
    }else {
        self.headerView.moneyLb.text = @"*****";
        self.headerView.todayLb.text = @"*****";
    }
}
#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 53;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETWalletDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETWalletDetailCell"];
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    if (indexPath.row == 0) {
        cell.titleLb.text = @"钱包名称";
        cell.titleLb.textColor = UIColorFromHEX(0x999999, 1);
        cell.detailLb.text = self.walletName;
        cell.detailLb.hidden = NO;
        cell.BtnCopy.hidden = YES;
        cell.arrowImage.hidden = YES;
    }else if (indexPath.row == 1) {
        cell.titleLb.text = @"钱包地址";
        cell.detailLb.text = model.address;
        cell.titleLb.textColor = UIColorFromHEX(0x999999, 1);
        cell.detailLb.hidden = false;
        cell.BtnCopy.hidden = NO;
        cell.arrowImage.hidden = NO;
    }else if (indexPath.row == 2) {
        cell.titleLb.text = @"修改密码";
        cell.titleLb.textColor = UIColorFromHEX(0x3333333, 1);
        cell.detailLb.hidden = YES;
        cell.BtnCopy.hidden = YES;
        cell.arrowImage.hidden = NO;
    }else if (indexPath.row == 3) {
        cell.titleLb.text = @"导出私钥";
        cell.titleLb.textColor = UIColorFromHEX(0x333333, 1);
        cell.detailLb.hidden = YES;
        cell.BtnCopy.hidden = YES;
        cell.arrowImage.hidden = NO;
    }else if (indexPath.row == 4) {
        cell.titleLb.text = @"导出Keystore";
        cell.titleLb.textColor = UIColorFromHEX(0x333333, 1);
        cell.detailLb.hidden = YES;
        cell.BtnCopy.hidden = YES;
        cell.arrowImage.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        ETChangePassWordController *vc = [ETChangePassWordController new];
        vc.selectTag = self.selectWallect;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 3) {
        
        ETVerifyPassWrodView *view = [[ETVerifyPassWrodView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [view setSuccess:^{
            ETImportSyaoController *vc = [ETImportSyaoController new];
            vc.selectTag = self.selectWallect;
            [self.navigationController pushViewController:vc animated:true];
        }];
        [view setFailure:^{
            [KMPProgressHUD showText:@"密码错误"];
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        
       
    }else if (indexPath.row == 4) {
        
        ETVerifyPassWrodView *view = [[ETVerifyPassWrodView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [view setSuccess:^{
            ETKeystoreImportController *vc = [ETKeystoreImportController new];
            vc.selectTag = self.selectWallect;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [view setFailure:^{
            [KMPProgressHUD showText:@"密码错误"];
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        
    }
    
   
    
}
#pragma mark - lazy load
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


@end
