//
//  ETDirectNormalCell.h
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ETDirectNormalCellDelegate <NSObject>

- (void)ETDirectNormalCellDelegateTextField:(UITextField *)textfiled;

@end

@interface ETDirectNormalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (weak, nonatomic) IBOutlet UILabel *arrowLb;

@property (nonatomic, weak) id <ETDirectNormalCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
