//
//  ETProclamListCell.h
//  ProjectET
//
//  Created by hufeng on 2019/11/12.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETNewsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETProclamListCell : UITableViewCell

@property (nonatomic,strong) UIView *docView;

@property (nonatomic,strong) UILabel *titleLb;

@property (nonatomic,strong) UILabel *timeLb;

@property (nonatomic,strong) ETNewsData *model;

@end

NS_ASSUME_NONNULL_END
