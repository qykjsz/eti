//
//  MinePushViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MinePushViewController.h"

@interface MinePushViewController ()

@end

@implementation MinePushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推送通知";
    
    NSArray *titleArray = @[@"接收推送通知",@"转账通知",@"聊天消息通知"];
    for (int i = 0;  i < 3; i++) {
        UILabel *title = [ClassBaseTools labelWithFont:16 textColor:[UIColor blackColor] textAlignment:0];
        title.text = titleArray[i];
        [self.view addSubview:title];
        float heigh;
        if(i==0){
            heigh = 15;
            UISwitch *swBtn= [[UISwitch alloc]init];
            swBtn.on = YES;
            swBtn.transform = CGAffineTransformMakeScale(0.75, 0.75);
            [self.view addSubview:swBtn];
            [swBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-20);
                make.top.mas_offset(heigh);
            }];
            
        }else if (i == 1) {
            heigh = 60;
        }else{
            heigh = 200;
        }
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(heigh);
        }];
    }
    NSArray *detailTitleArray = @[@"普通钱包转账通知",@"观察钱包转账通知",@"接收聊天消息通知",@"震动",@"声音"];
    for (int i = 0;  i<  5; i++) {
        UILabel *title = [ClassBaseTools labelWithFont:14 textColor:[UIColor blackColor] textAlignment:0];
        title.text = detailTitleArray[i];
        [self.view addSubview:title];
        float heigh;
        if(i==0){
            heigh = 110;
        }else if (i == 1) {
            heigh = 160;
        }else if (i == 2) {
            heigh = 247;
        }else if (i == 3){
            heigh = 284;
        }else{
            heigh = 328;
        }
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(30);
            make.top.mas_offset(heigh);
        }];
        UISwitch *swBtn= [[UISwitch alloc]init];
        swBtn.on = YES;
        swBtn.transform = CGAffineTransformMakeScale(0.75, 0.75);
        [self.view addSubview:swBtn];
        [swBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.top.mas_offset(heigh);
         
        }];
    }
}


@end
