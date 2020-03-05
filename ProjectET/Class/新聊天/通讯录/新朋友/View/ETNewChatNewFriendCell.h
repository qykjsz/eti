//
//  ETNewChatNewFriendCell.h
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETNewChatNewFriendModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ETNewChatNewFriendCellDelegate <NSObject>

- (void)ETNewChatNewFriendCellAgreeDelegate:(NSString *)uid;

- (void)ETNewChatNewFriendCellCancelDelegate:(NSString *)uid;

@end


@interface ETNewChatNewFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_mas;
@property (weak, nonatomic) IBOutlet UILabel *lab_remark;
@property (weak, nonatomic) IBOutlet UIButton *btn_agree;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@property (nonatomic, strong) ETNewChatNewFriendDataModel *model;
@property (nonatomic,weak) id <ETNewChatNewFriendCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
