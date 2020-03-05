//
//  ETNewBaseChatViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewBaseChatViewController.h"
#import "ETNewChatFristViewController.h"
#import "ETNewChatAddressBookViewController.h"
#import "ETNewChatMineViewController.h"
@interface ETNewBaseChatViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn_select;
@property (weak, nonatomic) IBOutlet UIView *view_slide;
@property (weak, nonatomic) IBOutlet UIView *view_background;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ETNewChatFristViewController *chatVC;
@property (nonatomic, strong) ETNewChatAddressBookViewController *addVC;
@property (nonatomic, strong) ETNewChatMineViewController *mimeVC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrain_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrain_titleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrain_backTop;

@end

@implementation ETNewBaseChatViewController

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

    // Do any additional setup after loading the view from its nib.
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

    self.chatVC = [[ETNewChatFristViewController alloc]init];
    self.addVC = [[ETNewChatAddressBookViewController alloc]init];
    self.mimeVC = [[ETNewChatMineViewController alloc]init];
    
    self.chatVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
    self.addVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
    self.mimeVC.view.frame = CGRectMake(SCREEN_WIDTH *2, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
    
    [self addChildViewController:self.chatVC];
    [self addChildViewController:self.addVC];
    [self addChildViewController:self.mimeVC];
    
    [self.scrollView addSubview:self.chatVC.view];
    [self.scrollView addSubview:self.addVC.view];
    [self.scrollView addSubview:self.mimeVC.view];
    
    [self.chatVC didMoveToParentViewController:self];
    [self.addVC didMoveToParentViewController:self];
    [self.mimeVC didMoveToParentViewController:self];
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
    if (sender.tag - 500 == 1) {
        [self.addVC getRongyunMyfriends];
    }else if (sender.tag - 500 == 0){

    }else if (sender.tag - 500 == 2){
        [self.mimeVC getChatSelusername];
    }
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
        [_scrollView setScrollEnabled:NO];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 3, 0)];
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }
    
    return _scrollView;
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//}


//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    UIButton *btn = [self.view viewWithTag:(self.scrollView.contentOffset.x / SCREEN_WIDTH) + 500];
//    [self actionOfBtn:btn];
//}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
