//
//  RCSegmentView.m
//  ProjectOne
//
//  Created by RongCheng on 16/3/31.
//  Copyright © 2016年 JiYue.com. All rights reserved.
//

#import "RCSegmentView.h"
#define KSegment 40
@implementation RCSegmentView

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC
{
    if ( self=[super initWithFrame:frame])
    {
        
        
        
        self.controllers=controllers;
        self.nameArray=titleArray;
        
        self.segmentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, KSegment)];
        self.segmentView.tag=50;
        self.segmentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.segmentView];
        
//        UIView *topView = [ClassBaseTools viewWithBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wo_top_bg"]]];
//        [self.segmentView addSubview:topView];
//        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_offset(0);
//            make.width.mas_offset(SCREEN_WIDTH);
//            make.height.mas_offset(138);
//            make.top.mas_offset(-kStatusBarHeight);
//        }];
        
        self.segmentScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, KSegment, frame.size.width, frame.size.height -KSegment)];
    self.segmentScrollV.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.segmentScrollV.delegate=self;
        self.segmentScrollV.showsHorizontalScrollIndicator=NO;
        self.segmentScrollV.pagingEnabled=YES;
        self.segmentScrollV.bounces=NO;
        [self addSubview:self.segmentScrollV];
        
        for (int i=0;i<self.controllers.count;i++)
        {
            UIViewController * contr=self.controllers[i];
            [self.segmentScrollV addSubview:contr.view];
            contr.view.frame=CGRectMake(i*frame.size.width, 0, frame.size.width,frame.size.height);
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        for (int i=0;i<self.controllers.count;i++)
        {
            UIButton * btn=[ UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count, KSegment);
            btn.tag=i;
            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font=[UIFont systemFontOfSize:14];
            if (i==0)
            {
                btn.selected=YES ;
                self.seleBtn=btn;
            } else {
                btn.selected=NO;
            }
            
            [self.segmentView addSubview:btn];
        }
        self.line=[[UILabel alloc]initWithFrame:CGRectMake(20,KSegment-5, frame.size.width/self.controllers.count- 40, 1)];
        self.line.backgroundColor = [UIColor whiteColor];
        self.line.tag = 100;
        [self.segmentView addSubview:self.line];
}
    
    
    return self;
}
- (void)Click:(UIButton*)sender
{
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:sender userInfo:nil];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
    }];
    UIButton * btn=(UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected=NO;
    self.seleBtn=btn;
    self.seleBtn.selected=YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
