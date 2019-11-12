//
//  MineRecordCell.h
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineRecordCell : UITableViewCell
@property(nonatomic,strong)UILabel *recordName;
@property(nonatomic,strong)UILabel *moneyValue;
@property(nonatomic,strong)UILabel *stateValue;
@property(nonatomic,strong)UILabel *timeValue;
@end

NS_ASSUME_NONNULL_END
