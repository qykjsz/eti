//
//  ETWalletMangerController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/8.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETWalletMangerController.h"
#import "ETCreatMyWalletViewController.h"
#import "ETWalletMangerView.h"
#import "ETWalletDetailController.h"
@interface ETWalletMangerController ()<ETWalletMangerViewDelegate>

@property (nonatomic,strong) ETWalletMangerView *walletView;

@end

@implementation ETWalletMangerController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.walletView reloadData];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self pageLayout];
    
    
}

- (void)pageLayout {
    
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
    titleLb.text = @"钱包管理";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.centerY.equalTo(popBtn.mas_centerY);
        
    }];
    
    self.walletView = [[ETWalletMangerView alloc]init];
    self.walletView.delegate = self;
    [self.view addSubview:self.walletView];
    [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        
    }];
}

#pragma mark - ETWalletMangerViewDelegate
- (void)ETWalletMangerViewDelegateAddWallet {
    
    ETCreatMyWalletViewController *cVC = [ETCreatMyWalletViewController new];
    [self.navigationController pushViewController:cVC animated:YES];
    
}

- (void)ETWalletMangerViewDelegateDidSelect:(NSIndexPath *)path model:(ETWalletModel *)model {
    
    ETWalletDetailController *dVC = [ETWalletDetailController new];
    [self.navigationController pushViewController:dVC animated:YES];
    
}

#pragma Mark - Action
- (void)popAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
