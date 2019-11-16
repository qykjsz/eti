//
//  ETNewFoundController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewFoundController.h"
#import "ETFoundSearchController.h"

#import "ETFoundHeaderView.h"

#import "ETFoundDappModel.h"
#import "ETFoundBannerModel.h"



@interface ETNewFoundController ()

@property (nonatomic,strong) ETFoundHeaderView *headerView;



@end

@implementation ETNewFoundController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [HTTPTool requestDotNetWithURLString:@"et_app" parameters:nil type:kPOST success:^(id responseObject) {
        
       
        ETFoundDappModel *model = [ETFoundDappModel mj_objectWithKeyValues:responseObject];
        self.headerView.dataArr = model.data;
        
    } failure:^(NSError *error) {
        
    }];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)bannerRequest {
    
    [HTTPTool requestDotNetWithURLString:@"api_banner" parameters:nil type:kPOST success:^(id responseObject) {
        
         ETFoundBannerModel *model = [ETFoundBannerModel mj_objectWithKeyValues:responseObject];
        NSMutableArray *dataArr = [NSMutableArray array];
        for (FoundBannerData *data in model.data) {
            [dataArr addObject:data.url];
        }
//        self.headerView.bannerView.imageDatas = dataArr;
    } failure:^(NSError *error) {
        
    }];
}

- (void)clickAction {
    
    ETFoundSearchController *sVC = [ETFoundSearchController new];
    sVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sVC animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bannerRequest];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(120);
    }];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(15, kStatusBarHeight+5, SCREEN_WIDTH-70, 31)];
    field.placeholder = @"搜索DApp或输入链接进入玩耍";
    field.backgroundColor = UIColorFromHEX(0x4F89FC, 1);
    field.font = [UIFont systemFontOfSize:14];
    field.layer.masksToBounds = YES;
    field.layer.cornerRadius = 15;
    [field setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    field.leftViewMode = UITextFieldViewModeAlways;
    field.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 10)];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, -3, 16, 18)];
    icon.image = [UIImage imageNamed:@"fx_spusuo"];
    [field.leftView addSubview:icon];
    UIButton *clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-70, 31)];
    [clickBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [field addSubview:clickBtn];
    [topImage addSubview:field];
    
    UIButton *scan = [UIButton buttonWithType:UIButtonTypeCustom];
    [scan setImage:[UIImage imageNamed:@"sy_sao"] forState:UIControlStateNormal];
    scan.frame = CGRectMake(SCREEN_WIDTH - 30, kStatusBarHeight+5, 23, 23);
    [topImage addSubview:scan];
    [scan mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(field.mas_centerY);
        make.width.height.mas_equalTo(23);
        make.right.equalTo(topImage.mas_right).offset(-15);
        
    }];
    
    self.headerView = [[ETFoundHeaderView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+55, SCREEN_WIDTH, 450)];
    [self.view addSubview:self.headerView];
    
    [HTTPTool requestDotNetWithURLString:@"et_app" parameters:nil type:kPOST success:^(id responseObject) {
        ETFoundDappModel *model = [ETFoundDappModel mj_objectWithKeyValues:responseObject];
        self.headerView.dataArr = model.data;
    } failure:^(NSError *error) {
        
    }];
    
    
   
    
}



@end
