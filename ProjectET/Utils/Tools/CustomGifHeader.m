//
//  CustomGifHeader.m
//  ProjectET
//
//  Created by mac on 2019/12/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "CustomGifHeader.h"

@implementation CustomGifHeader


#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
    //GIF数据
//    NSArray * idleImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:45];
    NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:45];
    //普通状态
//    [self setImages:idleImages duration:idleImages.count * 0.05 forState:MJRefreshStateIdle];
    [self setImages:refreshingImages duration:refreshingImages.count * 0.05 forState:MJRefreshStatePulling];
    self.gifView.contentMode = UIViewContentModeScaleAspectFill;
//    [self setImages:refreshingImages duration:refreshingImages.count * 0.05 forState:MJRefreshStateRefreshing];
//    [self setImages:idleImages forState:MJRefreshStateIdle];
    //即将刷新状态
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //正在刷新状态
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}


#pragma mark - 获取资源图片
- (NSArray *)getRefreshingImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray * imageArray = [NSMutableArray array];
    for (NSUInteger i = startIndex; i <= endIndex; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"jzdh_%ld",i]];
        if (image) {
            [imageArray addObject:image];
        }
    }
    return imageArray;
}

#pragma mark - 实现父类的方法
- (void)placeSubviews {
    [super placeSubviews];
    //隐藏状态显示文字
    self.stateLabel.hidden = YES;
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
