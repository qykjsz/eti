//
//  ETNewChatAddressCell.h
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETNewChatAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;

- (void)reloadCellForDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
