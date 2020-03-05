//
//  ETGroupMembersCell.h
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETGroupMembersModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETGroupMembersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_shenfen;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (nonatomic,strong) ETGroupMembersDataModel *model;
@end

NS_ASSUME_NONNULL_END
