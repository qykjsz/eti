//
//  ETNewInformationViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewInformationViewController.h"
#import "ETNewArticleViewController.h"
#import "ETNewMarketViewController.h"
#import "ETNewAlertsViewController.h"

@interface ETNewInformationViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn_select;
@property (weak, nonatomic) IBOutlet UIView *view_slide;
@property (weak, nonatomic) IBOutlet UIView *view_background;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ETNewAlertsViewController *aleVC;
@property (nonatomic, strong) ETNewArticleViewController *artVC;
@property (nonatomic, strong) ETNewMarketViewController *markVC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrain_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrain_titleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrain_backTop;

@end

@implementation ETNewInformationViewController

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
    if (!iPhoneBang){
        self.constrain_top.constant = -20;
    }else {
        self.constrain_top.constant = -44;
        self.constrain_titleTop.constant = 40;
         self.constrain_backTop.constant = -51;
    }
    [self layoutUI];
}

- (void)layoutUI {
    [self.view_background addSubview:self.scrollView];
    self.aleVC = [[ETNewAlertsViewController alloc]init];
    self.artVC = [[ETNewArticleViewController alloc]init];
    self.markVC = [[ETNewMarketViewController alloc]init];
    
    self.aleVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
    self.artVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
    self.markVC.view.frame = CGRectMake(SCREEN_WIDTH *2, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
    
    [self addChildViewController:self.aleVC];
    [self addChildViewController:self.artVC];
    [self addChildViewController:self.markVC];
    
    [self.scrollView addSubview:self.aleVC.view];
    [self.scrollView addSubview:self.artVC.view];
    [self.scrollView addSubview:self.markVC.view];
    
    [self.aleVC didMoveToParentViewController:self];
    [self.artVC didMoveToParentViewController:self];
    [self.markVC didMoveToParentViewController:self];
    [self actionOfBtn:self.btn_select];
}

///快讯 文章 行情
- (IBAction)actionOfBtn:(UIButton *)sender {
    self.btn_select.titleLabel.font = [UIFont systemFontOfSize:14];
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.btn_select.enabled = YES;
    self.btn_select = sender;
    self.btn_select.enabled = NO;
    
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (sender.tag - 500) , 0)];
    
    [UIView animateWithDuration:0.35 animations:^{
        CGPoint center = self.view_slide.center;
        center.x = sender.center.x;
        self.view_slide.center = center;
        [self.view_slide bringSubviewToFront:sender];
    }];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        if (!iPhoneBang){
             _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 77)];
        }else {
            _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 83 - 97)];
        }
        _scrollView.backgroundColor = UIColor.clearColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
//        [_scrollView setScrollEnabled:NO];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 3, 0)];
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }
    
    return _scrollView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    UIButton *btn = [self.view viewWithTag:(self.scrollView.contentOffset.x / SCREEN_WIDTH) + 500];
    [self actionOfBtn:btn];
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
