//
//  HoverPageViewController.m
//  HoverPageViewController <https://github.com/QiaokeZ/iOS_HoverPageViewController>
//
//  Created by admin on 2019/2/27
//  Copyright © 2019 zhouqiao. All rights reserved.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "HoverPageViewController.h"

@implementation HoverChildViewController
@end



@implementation HoverPageScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
@end

@interface HoverPageViewController ()<UIScrollViewDelegate,HoverChildViewControllerDelegate>
@property(nonatomic, strong) UIScrollView *pageScrollView;
@end

@implementation HoverPageViewController

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                             headerView:(UIView *)headerView
                          pageTitleView:(UIView *)pageTitleView{
    if (self = [super initWithNibName:nil bundle:nil]){
        _viewControllers = viewControllers;
        _headerView = headerView;
        _pageTitleView = pageTitleView;
    }
    return self;
}

+ (instancetype)viewControllers:(NSArray<HoverChildViewController *> *)viewControllers
                     headerView:(UIView *)headerView
                  pageTitleView:(UIView *)pageTitleView{
    return [[HoverPageViewController alloc]initWithViewControllers:viewControllers headerView:headerView pageTitleView:pageTitleView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareView];
}

- (void)prepareView{
    self.mainScrollView = [[HoverPageScrollView alloc]init];
//    self.mainScrollView.bounces = NO;
    self.mainScrollView.delegate = self;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:_headerView];
    [self.mainScrollView addSubview:_pageTitleView];
    
    self.pageScrollView = [[UIScrollView alloc]init];
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.delegate = self;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    [self.mainScrollView addSubview:self.pageScrollView];
    for (HoverPageViewController *vc in self.viewControllers) {
        CGRect frame = vc.view.frame;
        frame.size.width = SCREEN_WIDTH;
        vc.view.frame = frame;
        [self.pageScrollView addSubview:vc.view];
        [self addChildViewController:vc];
    }
    if (@available(iOS 11.0, *)){
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.mainScrollView.frame = self.view.bounds;
    self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.frame.size.height + self.headerView.frame.size.height);
    _pageTitleView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame),  _pageTitleView.frame.size.width,  _pageTitleView.frame.size.height);
    self.pageScrollView.frame = CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), SCREEN_WIDTH, self.mainScrollView.contentSize.height - CGRectGetMaxY(_pageTitleView.frame));
    self.pageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _viewControllers.count, 0);
    for (NSInteger i = 0; i < _viewControllers.count; i++) {
        HoverChildViewController *child = [_viewControllers objectAtIndex:i];
         child.view.frame = CGRectMake(i * SCREEN_WIDTH, child.view.frame.origin.y, SCREEN_WIDTH, child.view.frame.size.height);
        child.scrollDelegate = self;
       
    }
}

- (void)moveToAtIndex:(NSInteger)index animated:(BOOL)animated{
    for (HoverChildViewController *child in _viewControllers) {
        child.isCanScroll = YES;
    }
    [self.pageScrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidEndDecelerating:self.pageScrollView];
    });
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
     self.pageScrollView.scrollEnabled = YES;
     self.mainScrollView.scrollEnabled = YES;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageScrollView.scrollEnabled = YES;
    self.mainScrollView.scrollEnabled = YES;
    if (scrollView == self.pageScrollView){
        _currentIndex = (NSUInteger)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % _viewControllers.count;
        
        if ([self.delegate respondsToSelector:@selector(hoverPageViewController:scrollVIewDidEndDecelerating:)]) {
            [self.delegate hoverPageViewController:self scrollVIewDidEndDecelerating:scrollView];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView){
        self.pageScrollView.scrollEnabled = YES;
        HoverChildViewController *child = [_viewControllers objectAtIndex:_currentIndex];
        if (child.offsetY > 0){
            scrollView.contentOffset = CGPointMake(0, self.headerView.frame.size.height);
        }else{
            for (HoverChildViewController *child in _viewControllers) {
                child.offsetY = 0;
            }
        }
    }else if (scrollView == self.pageScrollView){
        self.mainScrollView.scrollEnabled = YES;
        if ([self.delegate respondsToSelector:@selector(hoverPageViewController:scrollViewDidScroll:)]){
            [self.delegate hoverPageViewController:self scrollViewDidScroll:scrollView];
        }
    }
}

- (void)hoverChildViewController:(HoverChildViewController *)ViewController scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.mainScrollView.contentOffset.y < self.headerView.frame.size.height && self.mainScrollView.contentOffset.y > 0){
        HoverChildViewController *child = [_viewControllers objectAtIndex:_currentIndex];
        child.offsetY = 0;
    }
}

@end
