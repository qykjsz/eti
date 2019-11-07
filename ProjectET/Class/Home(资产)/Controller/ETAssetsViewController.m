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
#import "ETMyWalletView.h"
#import "ETHomeModel.h"
@interface ETAssetsViewController ()<UITableViewDelegate,UITableViewDataSource,HomeHeaderViewDelegate,ETMyWalletViewDelegate,ETHomeTableHeaderViewDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) UIButton *clickBtn;

@property (nonatomic,strong) ETWalletModel *model;

@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic,strong) ETHomeModel *homeModel;
@end

@implementation ETAssetsViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self homeRequest];
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
    }
    return _detailTab;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"资产";
    self.isOpen = YES;
    
    self.model = [ETWalletManger getCurrentWallet];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenAction:) name:@"HIDDENDATA" object:nil];
    
    HomeHeaderView *headerView = [[HomeHeaderView alloc]init];
    [headerView.topLeftBtn setTitle:[NSString stringWithFormat:@"%@ >",self.model.walletName] forState:UIControlStateNormal];
    
    headerView.delegate = self;
    [self.view addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view.mas_top);
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(164);
        
    }];
    
    
   
   
    
    
    
    
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(headerView.mas_bottom).offset(-20);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
   
    
}


#pragma mark - NET

- (void)homeRequest {
    [HTTPTool requestDotNetWithURLString:@"et_home" parameters:@{@"address":@"0xa51c50c880d389b5bbd1c76308d3b544f54f39a4"} type:kPOST success:^(id responseObject) {
        self.homeModel = [ETHomeModel mj_objectWithKeyValues:responseObject];
        
        NSLog(@"%@",responseObject);
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (glodData *data in self.homeModel.data.glod) {
            [arr addObject:data.proportion];
        }
        
        ETHomeTableHeaderView *tableVIew = [[ETHomeTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 370) andProgress:arr];
        tableVIew.delegate = self;
        tableVIew.clipsToBounds = YES;
        tableVIew.layer.cornerRadius = 25;
        self.detailTab.tableHeaderView = tableVIew;
        
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - NoticeAction
- (void)hiddenAction:(NSNotification *)notice {
    self.isOpen = [notice.object[@"isOpen"] boolValue];
    [self.detailTab reloadData];
}

#pragma mark - ETHomeTableHeaderViewDelegate
- (void)ETHomeTableHeaderViewDelegateClickAction {
    
    ETWalletDetailController *DVC = [ETWalletDetailController new];
    DVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:DVC animated:YES];
    
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
            backUpViewController *backVC = [backUpViewController new];
            backVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:backVC animated:YES];
            break;
        }
        case 2: {
            ETCreatWalletViewController *cVC = [ETCreatWalletViewController new];
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

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.homeModel.data.glod.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETConiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETConiCell"];
    glodData *data = self.homeModel.data.glod[indexPath.row];
    
    cell.model = self.homeModel.data.glod[indexPath.row];
    if (!self.isOpen) {
        cell.topDollor.text = @"****.**";
        cell.bottomDollor.text = @"****.**";
    }else {
        cell.topDollor.text = data.number;
        cell.bottomDollor.text = [NSString stringWithFormat:@"$ %@",data.usdtnumber];
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
    [backView addSubview:textField];
    
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ETRecordSegmentController *dVC = [ETRecordSegmentController new];
    dVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dVC animated:YES];
    
}

#pragma mark - Action
- (void)pushToListAction {
    
    NSLog(@"pushToListAction");
}

@end
