//
//  ETAdvertisingH5ViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/17.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETAdvertisingH5ViewController.h"

@interface ETAdvertisingH5ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ETAdvertisingH5ViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lab_title.text = @"";
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.delegate = self;
    [self.webView setScalesPageToFit:YES];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)actionOfBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    [SVProgressHUD dismiss];
}

-(void)backHtml{
  
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
