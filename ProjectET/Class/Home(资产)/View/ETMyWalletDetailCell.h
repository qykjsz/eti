//
//  ETMyWalletDetailCell.h
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETMyWalletDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property (nonatomic,strong) ETWalletModel *model;
@property (weak, nonatomic) IBOutlet UILabel *topleftLb;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UILabel *topRightLb;
@property (weak, nonatomic) IBOutlet UILabel *walletName;
@property (weak, nonatomic) IBOutlet UILabel *bottoLb;


@end

NS_ASSUME_NONNULL_END
