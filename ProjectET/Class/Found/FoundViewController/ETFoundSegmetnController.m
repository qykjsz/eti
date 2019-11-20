//
//  ETFoundSegmetnController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/18.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundSegmetnController.h"
#import "HoverPageViewController.h"
#import "ETFoundSearchController.h"
#import "ETScanViewController.h"
#import "ETHTMLViewController.h"
#import "ETFoundHTMLViewController.h"
#import "ETFoundClassificationController.h"

// model
#import "ETFoundDappModel.h"
#import "ETFoundBannerModel.h"
#import "ETFoundCategoryModel.h"

//view
#import "ETFoundHeaderView.h"

#import "UUID.h"
#import <objc/runtime.h>

@interface ETFoundSegmetnController ()<HoverPageViewControllerDelegate,ETFoundHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UIView *indicator;

@property(nonatomic, strong) HoverPageViewController *hoverPageViewController;

@property (nonatomic,strong) UIButton *selectBtn;

@property (nonatomic,strong) UIView *pageTitleView;

@property (nonatomic,strong) ETFoundHeaderView *headerView;

@property (nonatomic,strong) NSMutableArray *viewControllers;

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSMutableArray *dappArr;

@end

@implementation ETFoundSegmetnController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self et_appnewsRequest];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self pageLayout];
    
    self.viewControllers = [NSMutableArray array];
    self.dappArr = [NSMutableArray array];
    /// 指示器
    self.pageTitleView = [UIView new];
    self.pageTitleView.backgroundColor = UIColor.whiteColor;
    self.pageTitleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    
   
   
    
    UIButton *button = self.pageTitleView.subviews.firstObject;
    [button layoutIfNeeded];
    
    [HTTPTool requestDotNetWithURLString:@"et_appantype" parameters:nil type:kPOST success:^(id responseObject) {
       
        ETFoundCategoryModel *models = [ETFoundCategoryModel mj_objectWithKeyValues:responseObject];
        NSLog(@"%@",models);
        
        
        /// 添加3个按钮
        CGSize buttonSize = CGSizeMake(60, self.pageTitleView.frame.size.height);
        for (int i = 0; i < models.data.count; i++) {
            FoundCategoryData *data = models.data[i];
            
            UIButton *button = [UIButton new];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(i * buttonSize.width, 0, buttonSize.width, buttonSize.height);
            [button setTitleColor:UIColorFromHEX(0xB7BCDC, 1) forState:UIControlStateNormal];
            [button setTitleColor:UIColorFromHEX(0x333333, 1) forState:UIControlStateSelected];
            if (i == 0) {
                self.selectBtn = button;
                self.selectBtn.selected = YES;
                [button setTitle:data.typenameString forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:16];
            }else {
                [button setTitle:data.typenameString forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:13];
            }
            [self.pageTitleView addSubview:button];
        }
        
        for (FoundCategoryData *data in models.data) {
            ETFoundClassificationController *vc1 = [[ETFoundClassificationController alloc]init];
            vc1.data = data.apps;
            vc1.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [self.viewControllers addObject:vc1];
        }
        
        [self setController];
        
    } failure:^(NSError *error) {
        
    }];

}


#pragma mark - 精选app接口
- (void)handpickRequest {
    
    [HTTPTool requestDotNetWithURLString:@"et_app" parameters:nil type:kPOST success:^(id responseObject) {
        
        
        ETFoundDappModel *model = [ETFoundDappModel mj_objectWithKeyValues:responseObject];
        
        NSInteger height = model.data.count % 5;
        if (height == 0) {
            height = model.data.count/5;
        }else {
            height = model.data.count/5 + 1;
        }
        self.headerView = [[ETFoundHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 332 + height * 80 + 20)];
//        self.hoverPageViewController.headerView = self.headerView;
        self.headerView.delegate = self;
        self.headerView.dataArr = model.data;
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)setController {
    
    /// 计算导航栏高度
    CGFloat barHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    
    [HTTPTool requestDotNetWithURLString:@"et_app" parameters:nil type:kPOST success:^(id responseObject) {
        
        
        ETFoundDappModel *model = [ETFoundDappModel mj_objectWithKeyValues:responseObject];
        
        NSInteger height = model.data.count % 5;
        if (height == 0) {
            height = model.data.count/5;
        }else {
            height = model.data.count/5 + 1;
        }
        self.headerView = [[ETFoundHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 332 + height * 80 + 20)];
        self.headerView.delegate = self;
        self.headerView.dataArr = model.data;
        
        
        self.hoverPageViewController = [HoverPageViewController viewControllers:self.viewControllers headerView:self.headerView pageTitleView:self.pageTitleView];
        self.hoverPageViewController.view.clipsToBounds = YES;
        self.hoverPageViewController.view.layer.cornerRadius = 15;
        self.hoverPageViewController.view.backgroundColor = UIColor.clearColor;
        self.hoverPageViewController.view.frame = CGRectMake(0, kStatusAndNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - barHeight);
        self.hoverPageViewController.delegate = self;
        self.hoverPageViewController.mainScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self bannerRequest];
            [self et_appnewsRequest];
            [self handpickRequest];
            [self.hoverPageViewController.mainScrollView.mj_header endRefreshing];
        }];
        [self addChildViewController:self.hoverPageViewController];
        [self.view addSubview:self.hoverPageViewController.view];
        
       
        
        [self bannerRequest];
        [self et_appnewsRequest];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

#pragma mark - ETFoundHeaderViewDelegate
- (void)ETFoundHeaderViewDelegateCollectionClick:(FoundDapp *)model {
    
    [self et_appnewRequest:model.Id];
    ETHTMLViewController *htmlVC = [ETHTMLViewController new];
    htmlVC.url = model.url;
    htmlVC.title = model.name;
    htmlVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:htmlVC animated:YES];
    
}

- (void)ETFoundHeaderViewDAppDelegateCollectionClick:(NSInteger)tag {
    
    FoundDapp *model = self.dappArr[tag];
    
    if (tag == 0) {
        NSURL *url = [NSURL URLWithString:@"ETUnion://"];
        BOOL isCanOpen = [[UIApplication sharedApplication] canOpenURL:url];
        if (isCanOpen) {
#ifdef NSFoundationVersionNumber_iOS_10_0
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
#else
            [[UIApplication sharedApplication] openURL:url];
#endif
            NSLog(@"App1打开App2");
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
    }else if(tag == 1){
        ETFoundHTMLViewController *vc = [[ETFoundHTMLViewController alloc]init];
        vc.url = [NSString stringWithFormat:@"%@?%@",model.url,[UUID getUUID]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:true];
        //        ETHTMLViewController *vc = [[ETHTMLViewController alloc]init];
        //        vc.url = @"https://ceshi.etac.io/dist";
        //        vc.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:vc animated:true];
    }else {
        ETHTMLViewController *vc = [ETHTMLViewController new];
        vc.url = model.url;
        vc.title = model.name;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:true];
    }
}

#pragma mark - 记录最近使用
- (void)et_appnewRequest:(NSString *)ID {
    
    NSString *uuidString = [UUID getUUID];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:ID forKey:@"appid"];
    [dict setValue:uuidString forKey:@"contacts"];
    [HTTPTool requestDotNetWithURLString:@"et_appnew" parameters:dict type:kPOST success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 广告
- (void)bannerRequest {
    
    [HTTPTool requestDotNetWithURLString:@"api_banner" parameters:nil type:kPOST success:^(id responseObject) {
        
        ETFoundBannerModel *model = [ETFoundBannerModel mj_objectWithKeyValues:responseObject];
        NSMutableArray *dataArr = [NSMutableArray array];
        for (FoundBannerData *data in model.data) {
            [dataArr addObject:data.url];
        }
        self.headerView.bannerView.imageDatas = dataArr;
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 最近使用app的列表
- (void)et_appnewsRequest {
    
    NSString *uuidString = [UUID getUUID];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:uuidString forKey:@"contacts"];
    [HTTPTool requestDotNetWithURLString:@"et_appnews" parameters:dict type:kPOST success:^(id responseObject) {
        
        [self.dappArr removeAllObjects];
        ETFoundDappModel *model = [ETFoundDappModel mj_objectWithKeyValues:responseObject];
//        FoundDapp *data = [[FoundDapp alloc]init];
//        data.img = @"ET合约";
//        data.name = @"猎鱼达人";
//        [dataArr addObject:data];
//
//        FoundDapp *data1 = [[FoundDapp alloc]init];
//        data1.img = @"fa_02";
//        data1.name = @"即可金服";
//        [dataArr addObject:data1];
        
        [self.dappArr addObjectsFromArray:model.data];
        
        self.headerView.topArr = self.dappArr;
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    return cell;
    
}


#pragma Mark - pageLayout
- (void)pageLayout {
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    WEAK_SELF(self);
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        STRONG_SELF(self);

         make.height.mas_equalTo(kStatusAndNavHeight + 20);
         make.left.top.right.equalTo(self.view);
        
    }];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(15, kStatusBarHeight+5, SCREEN_WIDTH-70, 31)];
    field.placeholder = @"搜索DApp或输入链接进入玩耍";
    field.backgroundColor = UIColorFromHEX(0x4F89FC, 1);
    field.font = [UIFont systemFontOfSize:14];
    field.layer.masksToBounds = YES;
    field.layer.cornerRadius = 15;
    Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(field, ivar);
    placeholderLabel.textColor = [UIColor whiteColor];
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
    [scan addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:scan];
    [scan mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(field.mas_centerY);
        make.width.height.mas_equalTo(23);
        make.right.equalTo(topImage.mas_right).offset(-15);
        
    }];
    
    UIView *whiteBackView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusAndNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    whiteBackView.backgroundColor = UIColor.whiteColor;
    whiteBackView.clipsToBounds = YES;
    whiteBackView.layer.cornerRadius = 15;
    [self.view addSubview:whiteBackView];
}
#pragma mark -
- (void)hoverPageViewController:(HoverPageViewController *)ViewController scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat progress = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.indicator.frame = CGRectMake(self.indicator.frame.size.width * progress, self.indicator.frame.origin.y, self.indicator.frame.size.width, self.indicator.frame.size.height);
    
}

- (void)hoverPageViewController:(HoverPageViewController *)ViewController scrollVIewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat progress = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    for (UIView *object in self.pageTitleView.subviews) {
        
        if ([object isKindOfClass:[UIButton class]]) {
            if (object.tag == progress) {
                UIButton *btn = (UIButton *)object;
                [self btnClickAction:btn];
            }
        }
    }
}

#pragma mark - Action
- (void)btnClickAction:(UIButton *)btn {
    
    self.selectBtn.selected = false;
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.selectBtn = btn;
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.selectBtn.selected = YES;
    
}

- (void)buttonClick:(UIButton *)btn{
    
    [self btnClickAction:btn];
    [self.hoverPageViewController moveToAtIndex:btn.tag animated:YES];
}

- (void)clickAction {
    
    ETFoundSearchController *sVC = [ETFoundSearchController new];
    sVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sVC animated:YES];
    
}

- (void)scanAction {
    
    ETScanViewController *sVC = [ETScanViewController new];
    [sVC setScanBlock:^(NSString * _Nonnull qcodeString) {
        ETHTMLViewController *vc = [[ETHTMLViewController alloc]init];
        vc.url = qcodeString;
        [self.navigationController pushViewController:vc animated:true];
    }];
    sVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sVC animated:YES];
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
