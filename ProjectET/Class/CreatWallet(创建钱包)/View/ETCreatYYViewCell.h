//
//  ETCreatYYViewCell.h
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYKit/YYKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETCreatYYViewCellDelegate <NSObject>

- (void)ETCreatYYViewCellDelegateSecertClick;

- (void)ETCreatYYViewCellDelegateTextView:(YYTextView *)textView;

@end

@interface ETCreatYYViewCell : UITableViewCell

@property (nonatomic,weak) id <ETCreatYYViewCellDelegate> delegate;

@property (nonatomic,strong) YYTextView *textView;

@property (nonatomic,strong) UIButton *clickBtn;

@end

NS_ASSUME_NONNULL_END
