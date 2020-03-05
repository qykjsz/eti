//
//  ETCharGroupAndFriendNoticeCell.h
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETCharGroupAndFriendNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ETCharGroupAndFriendNoticeDelegate <NSObject>

- (void)ETCharGroupAndFriendNoticeAgreeDelegate:(NSString *)Id AndQCode:(NSString *)qcode;

- (void)ETCharGroupAndFriendNoticeRefusedDelegate:(NSString *)Id AndQCode:(NSString *)qcode;

@end

@interface ETCharGroupAndFriendNoticeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_operation;
@property (weak, nonatomic) IBOutlet UILabel *lab_state;
@property (weak, nonatomic) IBOutlet UIButton *btn_agree;
@property (weak, nonatomic) IBOutlet UIButton *btn_refused;
@property (weak, nonatomic) IBOutlet UILabel *lab_msg;
@property (nonatomic, strong) ETCharGroupAndFriendNoticeListModel *friendModel;
@property (nonatomic, strong) ETCharGroupAndFriendNoticeListModel *groupModel;
@property (nonatomic,weak) id <ETCharGroupAndFriendNoticeDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lab_imgTitle;


@end

NS_ASSUME_NONNULL_END
