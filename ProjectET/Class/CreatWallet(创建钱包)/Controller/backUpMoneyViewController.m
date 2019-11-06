//
//  backUpMoneyViewController.m
//  ETDemon
//
//  Created by hufeng on 2019/10/28.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "backUpMoneyViewController.h"
#import "backUpViewController.h"

@interface backUpMoneyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titlesLb;
@property (weak, nonatomic) IBOutlet UILabel *subTitlesLB;
@property (weak, nonatomic) IBOutlet UILabel *safesTipsLb;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation backUpMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"备份钱包";
    self.titlesLb.textColor = UIColorFromHEX(0x000000, 1);
    self.subTitlesLB.textColor = UIColorFromHEX(0x999999, 1);
    self.safesTipsLb.textColor = UIColorFromHEX(0x999999, 1);
    self.backBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    self.backBtn.clipsToBounds = YES;
    self.backBtn.layer.cornerRadius = 5;
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)backAction {
    
    backUpViewController *backVC = [backUpViewController new];
    [self.navigationController pushViewController:backVC animated:YES];
    
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
