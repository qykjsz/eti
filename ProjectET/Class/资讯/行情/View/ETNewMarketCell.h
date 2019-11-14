//
//  ETNewMarketCell.h
//  ProjectET
//
//  Created by mac on 2019/11/14.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETNewMarketModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETNewMarketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_xMoney;
@property (weak, nonatomic) IBOutlet UILabel *lab_Smoney;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_zd;
@property (nonatomic,strong) ETNewMarketDatasModel *model;

@end

NS_ASSUME_NONNULL_END
