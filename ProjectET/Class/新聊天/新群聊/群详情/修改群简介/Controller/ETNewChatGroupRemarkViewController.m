//
//  ETNewChatGroupRemarkViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatGroupRemarkViewController.h"
#import "ETNewChatGroupChangeRemarkViewController.h"

@interface ETNewChatGroupRemarkViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_remark;
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_naem;

@end

@implementation ETNewChatGroupRemarkViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self getrongyunGroup];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群简介";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       rightBtn.frame = CGRectMake(0, 0, 52, 28);
       [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
       [rightBtn setTitleColor:UIColorFromHEX(0x353535, 1) forState:UIControlStateNormal];
       rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
       rightBtn.layer.cornerRadius = 3;
       rightBtn.layer.masksToBounds = YES;
       [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self getrongyunGroup];
    // Do any additional setup after loading the view from its nib.
}

///修改昵称
- (void)getrongyunGroup{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_group" parameters:@{@"qid":self.tid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.lab_naem.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
            [self.img_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]]]];
            self.qzid =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"qzid"]];
            self.lab_remark.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"introduce"]];
            self.remark  = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"introduce"]];
        }
//        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}

- (void)rightBtnAction{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    if (![model.ryID isEqualToString:self.qzid]) {
             [KMPProgressHUD showText:@"您不是群主，没有权限"];
             return;
         }
    ETNewChatGroupChangeRemarkViewController *vc = [ETNewChatGroupChangeRemarkViewController new];
    vc.tid = self.tid;
    vc.remark = self.remark;
    [self.navigationController pushViewController:vc animated:true];
    
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
