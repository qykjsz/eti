//
//  ETFoundSearchDetailCell.h
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETFoundDetailModel.h"
#import "ETFoundCategoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETFoundSearchDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTittleWidth;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (nonatomic,strong) ETFoundDetailData *model;

@property (nonatomic,strong) FoundCategoryApps *appModel;
@end

NS_ASSUME_NONNULL_END
