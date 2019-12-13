//
//  ETCoinInstructionsViewController.m
//  ProjectET
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETCoinInstructionsViewController.h"
#import "ETCoinInstructionsModel.h"
#import "ETHTMLViewController.h"

@interface ETCoinInstructionsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_coinName;
@property (weak, nonatomic) IBOutlet UIButton *btn_url;
@property (weak, nonatomic) IBOutlet UIButton *btn_bai;
@property (weak, nonatomic) IBOutlet UIButton *btn_issuetime;
@property (weak, nonatomic) IBOutlet UIButton *btn_issuenumber;
@property (weak, nonatomic) IBOutlet UIButton *btn_issueprice;
@property (weak, nonatomic) IBOutlet UILabel *lab_introduction;
@property (weak, nonatomic) IBOutlet UIView *view_noData;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) ETCoinInstructionsModel *model;
@end

@implementation ETCoinInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Token Profile";
    [self getGlodDetails];
    // Do any additional setup after loading the view from its nib.
}


- (void)getGlodDetails{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [HTTPTool requestDotNetWithURLString:@"glod_details" parameters:@{@"glod":self.glod} type:kPOST success:^(id responseObject) {
        self.model =[ETCoinInstructionsModel mj_objectWithKeyValues:responseObject];
        if (self.model.data.img == nil) {
            [self.scrollView setHidden:true];
            [self.view_noData setHidden:NO];
        }else {
            [self.scrollView setHidden:NO];
            [self.view_noData setHidden:true];
            [self.img_img sd_setImageWithURL: [NSURL URLWithString:self.model.data.img]];
            self.lab_coinName.text = self.glod;
            [self.btn_url setTitle:self.model.data.website forState:UIControlStateNormal];
            [self.btn_bai setTitle:[NSString stringWithFormat:@"%@ 白皮书",self.glod] forState:UIControlStateNormal];
            [self.btn_issuetime setTitle:self.model.data.issuetime forState:UIControlStateNormal];
            [self.btn_issuenumber setTitle:self.model.data.issuenumber forState:UIControlStateNormal];
            [self.btn_issueprice setTitle:self.model.data.issueprice forState:UIControlStateNormal];
            self.lab_introduction.text = self.model.data.introduction;
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

///官网
- (IBAction)actionOfWebSite:(UIButton *)sender {
    if ([self.model.data.website isEqualToString:@""]) {
        [KMPProgressHUD showText:@"暂无数据"];
    }else {
        ETHTMLViewController *vc = [ETHTMLViewController new];
        vc.url = self.model.data.website;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:true];
    }
}

///白皮书
- (IBAction)actionOfPaper:(UIButton *)sender {
    
    if ([self.model.data.paper isEqualToString:@""]) {
        [KMPProgressHUD showText:@"暂无数据"];
    }else {
        ETHTMLViewController *vc = [ETHTMLViewController new];
        vc.url = self.model.data.paper;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:true];
    }
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
