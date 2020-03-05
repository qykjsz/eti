//
//  ETChatCell.h
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETChatLishModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_mas;
@property (weak, nonatomic) IBOutlet UILabel *lab_titleImg;

@property (nonatomic,strong) ETChatLishAddfriendModel *friendModel;

@property (nonatomic,strong) ETChatLishAddgroupModel *groupModel;

@property (nonatomic,strong) ETChatLishcChatsModel *model;


@end

NS_ASSUME_NONNULL_END
