//
//  ETHTMLViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETHTMLViewController.h"

@interface ETHTMLViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ETHTMLViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    // 设置窗口亮度大小，范围是0.1 - 1.0
    [[UIScreen mainScreen] setBrightness: 0.8];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [SVProgressHUD dismiss];
}

- (void)popNavi {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.delegate = self;
    [self.webView setScalesPageToFit:YES];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,44,44)];
    
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstButton.frame = CGRectMake(0, 0, 44, 44);
    
    [firstButton setImage:[UIImage imageNamed:@"fh_icon"] forState:UIControlStateNormal];
    
    [firstButton addTarget:self action:@selector(backHtml) forControlEvents:UIControlEventTouchUpInside];

    firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    firstButton.tag = 10001;
    
    //    [firstButton setImageEdgeInsets:UIEdgeInsetsMake(0,0 *SCREEN_WIDTH /375.0,0,0)];
    
    
    
    
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:firstButton];
    
    
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    [SVProgressHUD dismiss];
}

-(void)backHtml{
    if ([self.webView canGoBack]) {
        // 网页可以返回 就进行网页返回
        [self.webView goBack];
    }else{
        [self.view resignFirstResponder];
        // 网页返回到首页了 返回不了了 这时候我们的控制器返回
        [self.navigationController popViewControllerAnimated:YES];
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
