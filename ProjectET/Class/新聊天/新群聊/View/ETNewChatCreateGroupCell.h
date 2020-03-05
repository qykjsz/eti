//
//  ETNewChatCreateGroupCell.h
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETNewChatCreateGroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;

@property (weak, nonatomic) IBOutlet UIImageView *img_sel;

- (void)reloadCellForDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
