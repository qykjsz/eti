//
//  ETAddressBookCell.h
//  ProjectET
//
//  Created by mac on 2020/1/3.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETAddressBookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ETAddressBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_igm;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_msg;
@property (nonatomic,strong) ETAddressBookDataModel *model;
@property (weak, nonatomic) IBOutlet UILabel *lab_titleTitle;

@end

NS_ASSUME_NONNULL_END
