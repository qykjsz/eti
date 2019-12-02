//
//  ETShopRecordCell.h
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETShopRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETShopRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_type;
@property (weak, nonatomic) IBOutlet UILabel *lab_from;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_fimoney;
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (nonatomic,strong) ETShopRecordOrderModel *model;
@end

NS_ASSUME_NONNULL_END
