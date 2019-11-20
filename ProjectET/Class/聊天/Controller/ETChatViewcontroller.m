//
//  ETChatViewcontroller.m
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETChatViewcontroller.h"

@interface ETChatViewcontroller ()

@end

@implementation ETChatViewcontroller

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
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kStatusAndNavHeight + 20);
    }];
    
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"聊天";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(iPhoneBang?kStatusBarHeight:(kStatusBarHeight + 5));
        
    }];
    
    UIView *whitView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusAndNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 80)];
    whitView.clipsToBounds = YES;
    whitView.layer.cornerRadius = 25;
    whitView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:whitView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lt_que"]];
    [whitView addSubview:imageView];
    WEAK_SELF(self);
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        STRONG_SELF(self);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(281);
        make.top.equalTo(whitView.mas_top).offset(68);
        
    }];
    
    UIButton *clickBtn = [[UIButton alloc]init];
    clickBtn.clipsToBounds = YES;
    clickBtn.layer.cornerRadius = 5;
    clickBtn.backgroundColor = UIColorFromHEX(0x999999, 1);
    [clickBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
    [clickBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [whitView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(imageView.mas_bottom).offset(80);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(44);
        
    }];
    
    
}


@end
