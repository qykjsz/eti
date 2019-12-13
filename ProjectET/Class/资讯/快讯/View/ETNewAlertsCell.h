//
//  ETNewAlertsCell.h
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETNewAlertsModel.h"


NS_ASSUME_NONNULL_BEGIN

@protocol ETNewAlertsCellDelegate <NSObject>

- (void)ETNewAlertsCellDelegateWithShare:(ETNewConalertNewsListData*)model;

@end

@interface ETNewAlertsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_conten;
@property (weak, nonatomic) IBOutlet UILabel *lab_all;
@property (weak, nonatomic) IBOutlet UILabel *lab_source;
@property (nonatomic,strong) ETNewConalertNewsListData *model;
@property (nonatomic,weak) id <ETNewAlertsCellDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
