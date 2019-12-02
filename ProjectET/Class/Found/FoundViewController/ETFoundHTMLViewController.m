//
//  ETFoundHTMLViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/18.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundHTMLViewController.h"
#import "ETDirectTransferController.h"//转账
#import <WebKit/WebKit.h>
@interface ETFoundHTMLViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic)   WKWebView                   *webView;
@property (strong, nonatomic)   UIProgressView              *progressView;

@end

@implementation ETFoundHTMLViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWKWebView];
    
    [self initProgressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)initWKWebView
{
  
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    
    //    NSString *urlStr = @"http://www.baidu.com";
    //    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    //    [self.webView loadRequest:request];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [self.webView loadRequest:request];
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate =self;
    [self.view addSubview:self.webView];
    
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

- (void)initProgressView
{
    CGFloat kScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    progressView.tintColor = [UIColor redColor];
    progressView.trackTintColor = [UIColor lightGrayColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}



#pragma mark - KVO
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            });
            
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}


#pragma mark - WKUIDelegate
//页面加载完成之后调用 : js注入
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.getElementsByClassName('header_top_wrap')[0].style.display='none'" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest *request = navigationAction.request;
    NSLog(@"%@",request.URL)
    if ([request.URL.host isEqualToString:@"webview"]) {
        NSArray *arr = [request.URL.absoluteString componentsSeparatedByString:@"address="];
        NSString *address = arr[1];
        ETDirectTransferController *vc = [[ETDirectTransferController alloc] init];
        vc.address = address;
        vc.coinNameString = @"ETH";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //类似于UIWebView里面的那个返回Yes的功能
    decisionHandler(WKNavigationActionPolicyAllow);
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
