//
//  ETWalletSearchCell.h
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETWalletSearchCellDelegate <NSObject>

- (void)ETWalletSearchCellDelegateTextfiled:(UITextField *)textfiled;

@end

@interface ETWalletSearchCell : UITableViewCell

@property (nonatomic,strong) UIImageView *iconImage;

@property (nonatomic,strong) UILabel *titleLb;

@property (nonatomic,strong) UILabel *subTitleLb;

@property (nonatomic,strong) UIButton *clickBtn;

@property (nonatomic,weak) id <ETWalletSearchCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
