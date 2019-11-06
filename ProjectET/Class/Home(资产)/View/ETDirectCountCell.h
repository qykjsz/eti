//
//  ETDirectCountCell.h
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETDirectCountCellDelegate <NSObject>

- (void)ETDirectCountCellDelegateTextField:(UITextField *)textfiled;

- (void)ETDirectCountCellDelegateFullCoinClick;

@end

@interface ETDirectCountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIButton *coninBtn;
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;

@property (nonatomic,weak) id <ETDirectCountCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
