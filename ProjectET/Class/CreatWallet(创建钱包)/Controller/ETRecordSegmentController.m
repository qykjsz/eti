

#import "ETRecordSegmentController.h"
#import "HoverPageViewController.h"
#import "ETRecordDetailViewController.h"
#import "ETGatheringViewController.h"
#import "ETTransferViewController.h"
#import "ETRecordHeaderView.h"
#import "ETTransListModel.h"
@interface ETRecordSegmentController ()<HoverPageViewControllerDelegate>
@property(nonatomic, strong) UIView *indicator;
@property(nonatomic, strong) HoverPageViewController *hoverPageViewController;

@property (nonatomic,strong) UIButton *selectBtn;

@property (nonatomic,strong) UIView *pageTitleView;

@property (nonatomic,strong) ETRecordHeaderView *headerView;

@property (nonatomic,strong) ETTransListModel *model;

@property (nonatomic,strong) ETRecordDetailViewController *vc1;

@property (nonatomic,strong) ETRecordDetailViewController *vc2;

@property (nonatomic,strong) ETRecordDetailViewController *vc3;

@property (nonatomic,assign) NSInteger currentPage;

@end

@implementation ETRecordSegmentController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}

#pragma Mark- NET
- (void)listRequest {
    
    /*
     address 复制    [string]    是    地址
     page    [string]    是    当前页数 从0开始
     glod    [string]    是    查询币种 如 ETH 传0为全部币种
     type    [string]    是    交易类型 1.转入 2.转入 3.全部
     */
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:model.address forKey:@"address"];
    [dict setValue:@(0) forKey:@"page"];
    [dict setValue:self.coinName forKey:@"glod"];
    [dict setValue:@"3" forKey:@"type"];
    [HTTPTool requestDotNetWithURLString:@"et_recordorder" parameters:dict type:kPOST success:^(id responseObject) {
        
        

        self.model = [ETTransListModel mj_objectWithKeyValues:responseObject];
        self.headerView.moneyLb.text = self.model.data.number;
        self.headerView.subMoneyLb.text = [NSString stringWithFormat:@"≈$ %@",self.model.data.usdtnumber];
        if ([self.model.data.today floatValue] >= 0) {
            self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 +%@",self.model.data.today];
        }else {
            self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 %@",self.model.data.today];
        }
       
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eyeAction:) name:@"RECODEREYEACTION" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(iPhoneBang?104:84);
        
    }];
    
    UIButton *popBtn = [[UIButton alloc]init];
    [popBtn setImage:[UIImage imageNamed:@"fh_icon_white"] forState:UIControlStateNormal];
    [popBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [popBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [popBtn addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:popBtn];
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topImage.mas_top).offset(iPhoneBang?34:20);
        make.width.height.equalTo(@44);
        
    }];
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = self.coinName;
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.centerY.equalTo(popBtn.mas_centerY);
        
    }];
    
    
    self.headerView = [[ETRecordHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    
    
    /// 指示器
    self.pageTitleView = [UIView new];
    self.pageTitleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    self.pageTitleView.backgroundColor = UIColor.whiteColor;
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 8, 105, 24)];
    textField.font = [UIFont systemFontOfSize:12];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 26, 15)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 13, 15)];
    [backView addSubview:image];
    image.image = [UIImage imageNamed:@"zc_sousuo"];
    textField.leftView = backView;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"搜索" attributes:
                                             @{NSForegroundColorAttributeName:UIColorFromHEX(0xc2c2c2, 1),
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:12]}];
    [textField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [textField addTarget:self action:@selector(textfieldDidChange2:) forControlEvents:UIControlEventEditingChanged];
    textField.attributedPlaceholder = attrString;
    textField.backgroundColor = UIColorFromHEX(0xF5F5F5, 1);
    textField.clipsToBounds = YES;
    textField.layer.cornerRadius = 12;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [self.pageTitleView addSubview:textField];
    
    /// 添加3个按钮
    CGSize buttonSize = CGSizeMake(60, self.pageTitleView.frame.size.height);
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton new];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(i * buttonSize.width, 0, buttonSize.width, buttonSize.height);
        [button setTitleColor:UIColorFromHEX(0xB7BCDC, 1) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromHEX(0x333333, 1) forState:UIControlStateSelected];
        if (i == 0) {
            self.selectBtn = button;
            self.selectBtn.selected = YES;
            [button setTitle:@"全部" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
        }else if (i == 1){
            [button setTitle:@"转入" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
        }else {
            [button setTitle:@"转出" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        [self.pageTitleView addSubview:button];
    }
    
    UIButton *button = self.pageTitleView.subviews.firstObject;
    [button layoutIfNeeded];
    
    /// 指示器底部
//    self.indicator = [UIView new];
//    self.indicator.frame = CGRectMake(0, buttonSize.height - 3, buttonSize.width, 3);
//    self.indicator.backgroundColor = [UIColor yellowColor];
//    [pageTitleView addSubview: self.indicator];
    
    /// 添加子控制器
    NSMutableArray *viewControllers = [NSMutableArray array];
    self.vc1 = [[ETRecordDetailViewController alloc]init];
    self.vc1.type = @"3";
    self.vc1.coinName = self.coinName;
    self.vc2 = [[ETRecordDetailViewController alloc]init];
    self.vc2.type = @"1";
    self.vc2.coinName = self.coinName;
    self.vc3 = [[ETRecordDetailViewController alloc]init];
    self.vc3.type = @"2";
    self.vc3.coinName = self.coinName;
    [viewControllers addObject:self.vc1];
    [viewControllers addObject:self.vc2];
    [viewControllers addObject:self.vc3];
    
    /// 计算导航栏高度
    CGFloat barHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    
    /// 添加分页控制器
    self.hoverPageViewController = [HoverPageViewController viewControllers:viewControllers headerView:self.headerView pageTitleView:self.pageTitleView];
    self.hoverPageViewController.view.frame = CGRectMake(0, iPhoneBang?(barHeight - 10):barHeight, SCREEN_WIDTH, SCREEN_HEIGHT - barHeight - 84);
    self.hoverPageViewController.delegate = self;
    [self addChildViewController:self.hoverPageViewController];
    [self.view addSubview:self.hoverPageViewController.view];
    
    [self.view addSubview:[self footerView]];
    
    [self listRequest];
    [self detailRequest];
}

- (void)textfieldDidChange:(UITextField *)textfiled {
    
    if (![Tools checkStringIsEmpty:textfiled.text]) {
        if (self.currentPage == 0) {
            self.vc1.temg = textfiled.text;
        }else if (self.currentPage == 1) {
            self.vc2.temg = textfiled.text;
        }else {
            self.vc3.temg = textfiled.text;
        }
    }

}

- (void)textfieldDidChange2:(UITextField *)textfiled {
    
    if ([Tools checkStringIsEmpty:textfiled.text]) {
        if (self.currentPage == 0) {
            self.vc1.temg = textfiled.text;
        }else if (self.currentPage == 1) {
            self.vc2.temg = textfiled.text;
        }else {
            self.vc3.temg = textfiled.text;
        }
    }
    
}

- (void)eyeAction:(NSNotification *)sender {
    
    if ([sender.object[@"isOpen"] boolValue]) {
        
        self.headerView.moneyLb.text = self.model.data.number;
        self.headerView.subMoneyLb.text = [NSString stringWithFormat:@"≈$ %@",self.model.data.usdtnumber];
        if ([self.model.data.today floatValue] >= 0) {
             self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 +%@",self.model.data.today];
        }else {
             self.headerView.todayLb.text = [NSString stringWithFormat:@"今日 %@",self.model.data.today];
        }
       
    }else {
        
        self.headerView.moneyLb.text = @"*****";
        self.headerView.subMoneyLb.text = @"≈$ *****";
        self.headerView.todayLb.text = @"******";
    }
}

- (void)buttonClick:(UIButton *)btn{
    
    [self btnClickAction:btn];
    self.currentPage = btn.tag;
    [self.hoverPageViewController moveToAtIndex:btn.tag animated:YES];
}

- (void)btnClickAction:(UIButton *)btn {
    
    self.selectBtn.selected = false;
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.selectBtn = btn;
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.selectBtn.selected = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)hoverPageViewController:(HoverPageViewController *)ViewController scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat progress = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.indicator.frame = CGRectMake(self.indicator.frame.size.width * progress, self.indicator.frame.origin.y, self.indicator.frame.size.width, self.indicator.frame.size.height);

}

- (void)hoverPageViewController:(HoverPageViewController *)ViewController scrollVIewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat progress = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.currentPage = progress;
    if (progress == 1.0) {
        for (UIView *object in self.pageTitleView.subviews) {
            
            if ([object isKindOfClass:[UIButton class]]) {
                if (object.tag == 1) {
                    UIButton *btn = (UIButton *)object;
                    [self btnClickAction:btn];
                }
            }
        }
    }else if (progress == 2.0) {
        for (UIView *object in self.pageTitleView.subviews) {
            
            if ([object isKindOfClass:[UIButton class]]) {
                if (object.tag == 2) {
                    UIButton *btn = (UIButton *)object;
                    [self btnClickAction:btn];
                }
            }
        }
    }else if (progress == 0) {
        for (UIView *object in self.pageTitleView.subviews) {
            
            if ([object isKindOfClass:[UIButton class]]) {
                if (object.tag == 0) {
                    UIButton *btn = (UIButton *)object;
                    [self btnClickAction:btn];
                }
            }
        }
    }
    
}


- (void)detailRequest {
    
    /*
     address 复制    [string]    是    地址
     page    [string]    是    当前页数 从0开始
     glod    [string]    是    查询币种 如 ETH 传0为全部币种
     type    [string]    是    交易类型 1.转入 2.转入 3.全部
     */
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:model.address forKey:@"address"];
    [dict setValue:@(0) forKey:@"page"];
    [dict setValue:self.coinName forKey:@"glod"];
    [dict setValue:@"3" forKey:@"type"];
    [HTTPTool requestDotNetWithURLString:@"et_recordorder" parameters:dict type:kPOST success:^(id responseObject) {
        
        
        self.model = [ETTransListModel mj_objectWithKeyValues:responseObject];
        
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)popAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)footerView {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 84, SCREEN_WIDTH, 84)];
    
    UIButton *leftBtn = [[UIButton alloc]init];
    leftBtn.clipsToBounds = YES;
    leftBtn.layer.cornerRadius = 5;
    leftBtn.tag = 0;
    [leftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"转账" forState:UIControlStateNormal];
    [leftBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    leftBtn.backgroundColor = UIColorFromHEX(0x00B792, 1);
    [backView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(backView.mas_left).offset(15);
        make.centerY.equalTo(backView.mas_centerY);
        make.width.equalTo(@((SCREEN_WIDTH-55)/2));
        make.height.mas_equalTo(44);
        
    }];
    
    UIButton *rightBtn = [[UIButton alloc]init];
    rightBtn.clipsToBounds = YES;
    rightBtn.layer.cornerRadius = 5;
    rightBtn.tag = 1;
    [rightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"收款" forState:UIControlStateNormal];
    [rightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    [backView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(backView.mas_right).offset(-15);
        make.centerY.equalTo(backView.mas_centerY);
        make.width.equalTo(@((SCREEN_WIDTH-55)/2));
        make.height.mas_equalTo(44);
        
    }];
    
    return backView;
    
}

- (void)clickAction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        ETTransferViewController *dVC = [ETTransferViewController new];
        [self.navigationController pushViewController:dVC animated:YES];
    }else {
        ETGatheringViewController *gVC = [ETGatheringViewController new];
        [self.navigationController pushViewController:gVC animated:YES];
    }
}


@end
