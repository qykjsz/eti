//
//  QuickViewCell.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuickViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *detail;
@end

NS_ASSUME_NONNULL_END
