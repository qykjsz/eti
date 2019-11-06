

#import "ETRecordSegmentController.h"
#import "HoverPageViewController.h"
#import "ETRecordDetailViewController.h"
#import "ETRecordHeaderView.h"

@interface ETRecordSegmentController ()<HoverPageViewControllerDelegate>
@property(nonatomic, strong) UIView *indicator;
@property(nonatomic, strong) HoverPageViewController *hoverPageViewController;

@property (nonatomic,strong) UIButton *selectBtn;

@property (nonatomic,strong) UIView *pageTitleView;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    titleLb.text = @"ETH";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.centerY.equalTo(popBtn.mas_centerY);
        
    }];
    
    
    ETRecordHeaderView * headerView = [[ETRecordHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    
    
    /// 指示器
    self.pageTitleView = [UIView new];
    self.pageTitleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 8, 85, 24)];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 26, 15)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 13, 15)];
    [backView addSubview:image];
    image.image = [UIImage imageNamed:@"zc_sousuo"];
    textField.leftView = backView;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"搜索" attributes:
                                             @{NSForegroundColorAttributeName:UIColorFromHEX(0xc2c2c2, 1),
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:12]}];
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
    ETRecordDetailViewController *vc1 = [[ETRecordDetailViewController alloc]init];
    ETRecordDetailViewController *vc2 = [[ETRecordDetailViewController alloc]init];
    ETRecordDetailViewController *vc3 = [[ETRecordDetailViewController alloc]init];
    [viewControllers addObject:vc1];
    [viewControllers addObject:vc2];
    [viewControllers addObject:vc3];
    
    /// 计算导航栏高度
    CGFloat barHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    
    /// 添加分页控制器
    self.hoverPageViewController = [HoverPageViewController viewControllers:viewControllers headerView:headerView pageTitleView:self.pageTitleView];
    self.hoverPageViewController.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - barHeight);
    self.hoverPageViewController.delegate = self;
    [self addChildViewController:self.hoverPageViewController];
    [self.view addSubview:self.hoverPageViewController.view];
}

- (void)buttonClick:(UIButton *)btn{
    
    [self btnClickAction:btn];
    
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



- (void)popAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
