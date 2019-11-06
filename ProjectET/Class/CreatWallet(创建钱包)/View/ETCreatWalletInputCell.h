//
//  ETCreatWalletInputCell.h
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETCreatWalletInputCellDelegate <NSObject>

- (void)ETCreatWalletInputCellDelegateTextfied:(UITextField *)fielde rowPath:(NSIndexPath *)path;

- (void)ETCreatWalletInputCellDelegateTextfiedSecuentry:(BOOL)isSecruty;

@end

@interface ETCreatWalletInputCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (weak, nonatomic) IBOutlet UIButton *hideBtn;
@property (nonatomic,strong) NSIndexPath *rowPath;
@property (nonatomic,weak) id <ETCreatWalletInputCellDelegate> delegate;

@property (nonatomic,strong) void (^securEntyBlock)(BOOL flag,NSIndexPath *rowPath);

@end

NS_ASSUME_NONNULL_END
