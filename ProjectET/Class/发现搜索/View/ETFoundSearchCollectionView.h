//
//  ETFoundSearchCollectionView.h
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETFoundSearchCollectionViewDelegate <NSObject>

- (void)ETFoundSearchCollectionViewDelegateClick:(NSString *)str;

@end

@interface ETFoundSearchCollectionView : UIView

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,weak) id <ETFoundSearchCollectionViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
