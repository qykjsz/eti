//
//  ETNewTwoMarketCell.h
//  ProjectET
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETNewMarketModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETNewTwoMarketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_allName;
@property (weak, nonatomic) IBOutlet UILabel *lab_zd;
@property (weak, nonatomic) IBOutlet UILabel *lab_xiamoney;
@property (weak, nonatomic) IBOutlet UILabel *lab_circulation;
@property (weak, nonatomic) IBOutlet UILabel *lab_num;
@property (weak, nonatomic) IBOutlet UILabel *lab_vol;
@property (nonatomic,strong) ETNewMarketDatasModel *model;
@end

NS_ASSUME_NONNULL_END
