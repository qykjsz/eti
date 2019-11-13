//
//  ETRecordCell.h
//  ProjectET
//
//  Created by hufeng on 2019/11/1.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTransListModel.h"
#import "ETHashSearchModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETRecordCell : UITableViewCell

@property (nonatomic,strong) UILabel *moneydetail;

@property (nonatomic,strong) UILabel *timeDetail;

@property (nonatomic,strong) UILabel *statusDetail;

@property (nonatomic,strong) orderData *model;

@property (nonatomic,strong) UILabel *topLB;

@property (nonatomic,strong) hashData *data;

@end

NS_ASSUME_NONNULL_END
