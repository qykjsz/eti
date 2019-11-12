//
//  FoundViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "FoundViewController.h"
#import "UIButton+ImageTitleSpacing.h"

@interface FoundViewController ()
@property (nonatomic,strong)UIScrollView *mainView;
@end

@implementation FoundViewController
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
    self.title = @"发现";
    
    [self creatFoundView];
    [self creatContentView];

}
- (void)creatFoundView{
    UIView *topView = [ClassBaseTools viewWithBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wo_top_bg"]]];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(118);
    }];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(15, kStatusBarHeight+5, SCREEN_WIDTH-70, 31)];
    field.placeholder = @"请输入玩耍app";
    field.font = [UIFont systemFontOfSize:14];
    field.layer.borderWidth = .5;
    field.layer.masksToBounds = YES;
    field.layer.cornerRadius = 15;
    [field setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    field.layer.borderColor = [[UIColor whiteColor] CGColor];
    field.leftViewMode = UITextFieldViewModeAlways;
    field.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 10)];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, -3, 16, 18)];
    icon.image = [UIImage imageNamed:@"fx_spusuo"];
    [field.leftView addSubview:icon];
    [topView addSubview:field];
    
    UIButton *scan = [UIButton buttonWithType:UIButtonTypeCustom];
    [scan setImage:[UIImage imageNamed:@"zjc_sao"] forState:UIControlStateNormal];
    scan.frame = CGRectMake(SCREEN_WIDTH - 30, kStatusBarHeight+5, 23, 23);
    [topView addSubview:scan];
    self.mainView = [[UIScrollView alloc]init];
    self.mainView.layer.masksToBounds = YES;
    self.mainView.layer.cornerRadius = 26;
    self.mainView.clipsToBounds = YES;
    self.mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.equalTo(topView.mas_bottom).offset(-20);
        make.height.mas_offset(SCREEN_HEIGHT-kTabBarHeight-100);
    }];
}
- (void)creatContentView{
    UIImageView *topImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fx_banner"]];
    [self.mainView addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(150);
        make.top.mas_offset(20);
    }];
    UILabel *myApp = [ClassBaseTools labelWithFont:17 textColor:[UIColor blackColor] textAlignment:0];
    myApp.text = @"我的DApp";
    [self.mainView addSubview:myApp];
    [myApp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.equalTo(topImg.mas_bottom).offset(20);
    }];
    
    for (int i = 0 ; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"fx_01"] forState:UIControlStateNormal];
        [btn setTitle:@"扑鱼达人" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.mainView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15+75*i);
            make.top.equalTo(myApp.mas_bottom).offset(30);
//            make.width.height.mas_offset(44);
        }];
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    }
    
    UILabel *selectApp = [ClassBaseTools labelWithFont:17 textColor:[UIColor blackColor] textAlignment:0];
    selectApp.text = @"精选DApp";
    [self.mainView addSubview:selectApp];
    [selectApp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.equalTo(myApp.mas_bottom).offset(110);
    }];
    for (int i = 0 ; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"fx_01"] forState:UIControlStateNormal];
        [btn setTitle:@"扑鱼达人" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.mainView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15+75*i);
            make.top.equalTo(selectApp.mas_bottom).offset(30);
//            make.width.height.mas_offset(44);
        }];
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    }
}
@end
