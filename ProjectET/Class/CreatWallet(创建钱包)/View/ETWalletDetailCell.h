//
//  ETWalletDetailCell.h
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETWalletDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *detailLb;
@property (weak, nonatomic) IBOutlet UIButton *BtnCopy;
@property (nonatomic,strong) UIImageView *arrowImage;
@end

NS_ASSUME_NONNULL_END
