//
//  ETAssetsViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/28.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETAssetsViewController.h"
#import "HomeHeaderView.h"
#import "ETHomeTableHeaderView.h"
#import "ETConiCell.h"
#import "UIButton+ImageTitleSpacing.h"
#import "backUpViewController.h"
#import "ETTransferViewController.h"
#import "ETCreatWalletViewController.h"
#import "ETGatheringViewController.h"
#import "ETWalletDetailController.h"
#import "ETWalletDetailController.h"
#import "ETRecordSegmentController.h"
#import "ETWalletSearchController.h"
#import "ETWalletMangerController.h"
#import "backUpMoneyViewController.h"
#import "ETCoinListViewController.h"
#import "ETScanViewController.h"
#import "ETProclamationListController.h"
#import "ETNewsDetailController.h"

#import "ETMyWalletView.h"
#import "ETHomeModel.h"
#import "ETBackUpWalletView.h"

#import "ETGatheringViewController.h"
@interface ETAssetsViewController ()<UITableViewDelegate,UITableViewDataSource,HomeHeaderViewDelegate,ETMyWalletViewDelegate,ETHomeTableHeaderViewDelegate,ETBackUpWalletViewDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) UIButton *clickBtn;

@property (nonatomic,strong) ETWalletModel *model;

@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,strong) ETHomeModel *homeModel;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) ETHomeTableHeaderView *headerView;

@property (nonatomic,strong) HomeHeaderView *homeHeader;

@end

@implementation ETAssetsViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    [self homeRequest];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 26;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETConiCell class] forCellReuseIdentifier:@"ETConiCell"];
        WEAK_SELF(self);
        _detailTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
            STRONG_SELF(self);
            [self.detailTab.mj_header endRefreshing];
            [self homeRequest];
            
        }];
    }
    return _detailTab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资产";
    self.isOpen = YES;
    self.model = [ETWalletManger getCurrentWallet];
    self.dataArr = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenAction:) name:@"HIDDENDATA" object:nil];
    
    ETWalletModel *walletModel = [ETWalletManger getCurrentWallet];
    self.homeHeader = [[HomeHeaderView alloc]init];
    [self.homeHeader.topLeftBtn setTitle:[NSString stringWithFormat:@"%@ >",walletModel.walletName] forState:UIControlStateNormal];
    
    self.homeHeader.delegate = self;
    [self.view addSubview:self.homeHeader];
    WEAK_SELF(self);
    [self.homeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        STRONG_SELF(self);
        make.top.equalTo(self.view.mas_top);
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(184);
        
    }];
    
    
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.homeHeader.mas_bottom).offset(-25);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
    //    NSMutableArray *arr = WALLET_ARR;
    //
    //    for (int i = 0; i<arr.count; i++) {
    //        ETWalletModel *model = arr[i];
    //        if (i == 0) {
    //            model.isCurrentWallet = YES;
    //        }else {
    //            model.isCurrentWallet = NO;
    //        }
    //        [ETWalletManger updateWallet:model];
    //    }
    [self homeRequest];
    
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
    [SVProgressHUD showWithStatus:@"正在加载"];
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"et_home" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
         [KMPProgressHUD dismissProgress];
        [self.dataArr removeAllObjects];
        self.homeModel = [ETHomeModel mj_objectWithKeyValues:responseObject];
        
        NSLog(@"%@",responseObject);
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (glodData *data in self.homeModel.data.glod) {
            [arr addObject:data.proportion];
        }
        [self.dataArr addObjectsFromArray:self.homeModel.data.glod];
        
        self.headerView = [[ETHomeTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 390) andProgress:self.homeModel.data.proportion];
        [self.headerView.selectView setHomeSelectTag:^(NSInteger tag) {
            [SVProgressHUD showInfoWithStatus:@"暂未开放"];
        }];
        
        
        
        NSMutableArray *dataArr = [NSMutableArray array];
        if (self.homeModel.data.news.count != 0 ) {
            for (newsData *data in self.homeModel.data.news) {
                [dataArr addObject:data.name];
            }
            [self.headerView setContentArr:dataArr];
        }
        
        self.headerView.delegate = self;
        self.headerView.clipsToBounds = YES;
        self.headerView.layer.cornerRadius = 25;
        self.detailTab.tableHeaderView = self.headerView;
        self.headerView.moneyLb.text = self.homeModel.data.allnumber;
        [self.homeHeader.topLeftBtn setTitle:[NSString stringWithFormat:@"%@ >",model.walletName] forState:UIControlStateNormal];
        if ([self.homeModel.data.today floatValue] >= 0) {
             self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 +%@",self.homeModel.data.today];
        }else {
             self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 %@",self.homeModel.data.today];
        }
       
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"加载失败"];
    }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETConiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETConiCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    glodData *data = self.dataArr[indexPath.row];
    
    cell.model = self.dataArr[indexPath.row];
    if (!self.isOpen) {
        cell.topDollor.text = @"****.**";
        cell.bottomDollor.text = @"****.**";
    }else {
        cell.topDollor.text = data.number;
        cell.bottomDollor.text = [NSString stringWithFormat:@"$ %@",data.usdtnumber];
        cell.coninName.text = data.name;
    }
    
    return  cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    backView.backgroundColor = UIColor.whiteColor;
    self.clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(-15, 0, 150, 44)];
    [self.clickBtn setTitle:@"全部资产" forState:UIControlStateNormal];
    [self.clickBtn setTitleColor:UIColorFromHEX(0x333333, 1) forState:UIControlStateNormal];
    self.clickBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.clickBtn setImage:[UIImage imageNamed:@"sy_xiajt"] forState:UIControlStateNormal];
    [self.clickBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [backView addSubview:self.clickBtn];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 39, 10, 24, 24)];
    [rightBtn setImage:[UIImage imageNamed:@"sy_jia"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(pushToListAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:rightBtn];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 54  - 85, 10, 85, 24)];
    UIView *TbackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 26, 15)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 13, 15)];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"搜索" attributes:
                                             @{NSForegroundColorAttributeName:UIColorFromHEX(0xc2c2c2, 1),
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:12]}
                                             ];
    textField.attributedPlaceholder = attrString;
    [TbackView addSubview:image];
    image.image = [UIImage imageNamed:@"zc_sousuo"];
    textField.leftView = TbackView;
    textField.backgroundColor = UIColorFromHEX(0xF5F5F5, 1);
    textField.clipsToBounds = YES;
    textField.layer.cornerRadius = 12;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [textField addTarget:self action:@selector(coninSearch:) forControlEvents:UIControlEventEditingChanged];
    [backView addSubview:textField];
    
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    glodData *data = self.dataArr[indexPath.row];
    ETRecordSegmentController *dVC = [ETRecordSegmentController new];
    dVC.coinName = data.name;
    dVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dVC animated:YES];
    
}

#pragma mark - ETHomeTableHeaderViewDelegate
- (void)ETHomeTableHeaderViewDelegateClickAction {
    
    ETWalletDetailController *DVC = [ETWalletDetailController new];
    DVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:DVC animated:YES];
    
}

- (void)ETHomeTableHeaderViewDelegateMoreClickAction {
    
    ETProclamationListController *pVC = [ETProclamationListController new];
    pVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pVC animated:YES];
    
}

- (void)ETHomeTableHeaderViewBannerDelegateClickAction:(NSInteger)tag {
    
    if (self.homeModel.data.news.count != 0) {
        ETNewsDetailController *dVC = [ETNewsDetailController new];
        newsData *data = self.homeModel.data.news[tag];
        dVC.Id = data.Id;
        dVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:dVC animated:YES];
    }
}

#pragma mark - HomeHeaderViewDelegate

-(void)HomeHeaderViewDelegateWithClickTag:(NSInteger)tag {
    
    switch (tag) {
        case 0: {
            ETMyWalletView *view = [[ETMyWalletView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            view.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:view];
            [view show];
            break;
        }
        case 1: {
            ETCoinListViewController *backVC = [ETCoinListViewController new];
            backVC.isCreatWallet = YES;
            backVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:backVC animated:YES];
            break;
        }
        case 2: {
            ETScanViewController *cVC = [ETScanViewController new];
            cVC.isDirection = YES;
            cVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cVC animated:YES];
            break;
        }
        case 3: {
            ETTransferViewController *tranVC = [ETTransferViewController new];
            tranVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tranVC animated:YES];
            break;
        }
        case 4: {
            ETGatheringViewController *gVC = [ETGatheringViewController new];
            gVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:gVC animated:YES];
            break;
        }
        case 5:
            [KMPProgressHUD showText:@"暂未开放"];
            break;
        default:
            break;
    }
}

#pragma mark - ETMyWalletViewDelegate
- (void)ETMyWalletViewDelegateAddWallet {
    
    ETCreatWalletViewController *creatVC = [ETCreatWalletViewController new];
    creatVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:creatVC animated:YES];
    
}

- (void)ETMyWalletViewDelegateWalletManger {
    
    ETWalletMangerController *mVC = [ETWalletMangerController new];
    mVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mVC animated:YES];
    
}

- (void)ETMyWalletViewDelegateDidSelect:(NSIndexPath *)indexPath {
    
    NSMutableArray *arr = WALLET_ARR;
    ETWalletModel *model = arr[indexPath.row];
    
//    if (!model.isBackUp) {
//        
//        ETBackUpWalletView *backView = [[ETBackUpWalletView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        backView.delegate = self;
//        backView.model = model;
//        [[UIApplication sharedApplication].keyWindow addSubview:backView];
//        
//    }
    
    /*--------------这一步是先取出当前钱包把当前状态改成不是当前的------------*/
    ETWalletModel *currentModel = [ETWalletManger getCurrentWallet];
    currentModel.isCurrentWallet = false;
    [ETWalletManger updateWallet:currentModel];
    /*--------------这一步是把点击选中的钱包置为当前钱包------------*/
    model.isCurrentWallet = YES;
    [ETWalletManger updateWallet:model];
    
    [ETWalletManger reloadData];
    
    self.headerView.moneyLb.text = self.homeModel.data.allnumber;
    [self.homeHeader.topLeftBtn setTitle:[NSString stringWithFormat:@"%@ >",model.walletName] forState:UIControlStateNormal];
    [self homeRequest];
    
    
    
}

#pragma mark - ETBackUpWalletViewDelegate
- (void)ETBackUpWalletViewDelegateDeletAction:(ETWalletModel *)model {
    
    [ETWalletManger deleWallet:model];
    [self homeRequest];
    [SVProgressHUD showInfoWithStatus:@"删除成功"];
    
}

- (void)ETBackUpWalletViewDelegateBackUpAction:(ETWalletModel *)model {
    
    backUpMoneyViewController *bcVC = [backUpMoneyViewController new];
    bcVC.model = model;
    bcVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bcVC animated:YES];
    
}

#pragma mark - Action
- (void)pushToListAction {
    
    ETWalletSearchController *sVC = [ETWalletSearchController new];
    sVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sVC animated:YES];
    
}

#pragma mark - NoticeAction
- (void)hiddenAction:(NSNotification *)notice {
    self.isOpen = [notice.object[@"isOpen"] boolValue];
    
    if (self.isOpen) {
        self.headerView.moneyLb.text = self.homeModel.data.allnumber;
        if ([self.homeModel.data.today floatValue] >= 0) {
            self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 +%@",self.homeModel.data.today];
        }else {
            self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 %@",self.homeModel.data.today];
        }
    }else {
        self.headerView.moneyLb.text = @"***.**";
        self.headerView.todayLb.text = @"*****";
    }
    [self.detailTab reloadData];
}


- (void)coninSearch:(UITextField *)textfiled {
    
    [self.dataArr removeAllObjects];
    for (glodData *data in self.homeModel.data.glod) {
        
        if ([data.name isEqualToString:[textfiled.text uppercaseString]]) {
            [self.dataArr addObject:data];
        }
    }
    
    if ([Tools checkStringIsEmpty:textfiled.text]) {
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:self.homeModel.data.glod];
    }
    [self.detailTab reloadData];
}

@end
