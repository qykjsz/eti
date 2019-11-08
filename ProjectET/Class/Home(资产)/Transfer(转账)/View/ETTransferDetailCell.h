//
//  ETTransferDetailCell.h
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETTransferDetailCellDelegate <NSObject>

- (void)ETTransferDetailCellDelegateWithRowPath:(NSIndexPath *)rowPath;

@end

@interface ETTransferDetailCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLb;

@property (nonatomic,strong) UILabel *detailLb;

@property (nonatomic,strong) UILabel *subDetailLb;

@property (nonatomic,strong) UIButton *clickBtn;

@property (nonatomic,strong) UIImageView *lineImage;

@property (nonatomic,strong) NSIndexPath *rowPath;

@property (nonatomic,weak) id <ETTransferDetailCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
