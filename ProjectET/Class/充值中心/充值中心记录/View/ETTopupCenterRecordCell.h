//
//  ETTopupCenterRecordCell.h
//  ProjectET
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTopupCenterRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETTopupCenterRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_gameName;
@property (weak, nonatomic) IBOutlet UILabel *lab_gameUser;
@property (weak, nonatomic) IBOutlet UILabel *lab_gameNumber;
@property (weak, nonatomic) IBOutlet UILabel *lab_money;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_state;

@property (nonatomic,strong) ETTopupCenterRecordOrderModel *model;

@end

NS_ASSUME_NONNULL_END
