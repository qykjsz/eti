//
//  ETNewArticleCell.h
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETNewArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETNewArticleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (nonatomic,strong) ETNewArticleDNewModel *model;
@end

NS_ASSUME_NONNULL_END
