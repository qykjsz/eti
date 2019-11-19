//
//  MineNodeCell.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineNodeCell : UITableViewCell
@property(nonatomic,strong)UILabel *nodeName;
@property(nonatomic,strong)UILabel *nodeAddress;
@property(nonatomic,strong)UILabel *speed;
@property(nonatomic,strong)UILabel *point;
@property(nonatomic,strong)UIImageView *selImg;
@end

NS_ASSUME_NONNULL_END
