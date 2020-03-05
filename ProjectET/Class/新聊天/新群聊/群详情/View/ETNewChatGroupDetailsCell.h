//
//  ETNewChatGroupDetailsCell.h
//  ProjectET
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETNewChatGroupDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETNewChatGroupDetailsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (nonatomic,strong) ETNewChatGroupDetailsDataModel *model;
@end

NS_ASSUME_NONNULL_END
