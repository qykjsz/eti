//
//  QuickViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "QuickViewController.h"

@interface QuickViewController ()

@end

@implementation QuickViewController
//- (void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:animated];
//    [self setHidesBottomBarWhenPushed:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//
//    [super viewWillDisappear:animated];
//    [self setHidesBottomBarWhenPushed:NO];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *quickImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kxfx_bg"]];
    quickImg.userInteractionEnabled = YES;
    quickImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:quickImg];
    [quickImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    
    UIButton *backBtn = [ClassBaseTools buttonWithFont:15 titlesColor:[UIColor whiteColor] contentHorizontalAlignment:0 title:@""];
    [backBtn setImage:[UIImage imageNamed:@"fh_icon_white"] forState:UIControlStateNormal];
    [quickImg addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(25);
        make.top.mas_offset(kNavBarHeight);
        make.width.mas_offset(9);
        make.height.mas_offset(20);
    }];
    
}
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
