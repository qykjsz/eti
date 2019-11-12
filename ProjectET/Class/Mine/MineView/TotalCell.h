//
//  TotalCell.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TotalCell : UITableViewCell
@property(nonatomic,strong)UILabel *type;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *number;
@property(nonatomic,strong)UILabel *money;
@end

NS_ASSUME_NONNULL_END
