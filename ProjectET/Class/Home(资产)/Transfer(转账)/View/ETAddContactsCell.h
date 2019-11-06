//
//  ETAddContactsCell.h
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETAddContactsCellDelegate <NSObject>
- (void)ETAddContactsCellDelegateTextfiled:(UITextField *)textfiled rowPath:(NSIndexPath *)rowPath;
- (void)ETAddContactsCellDelegateScanClick;
@end

@interface ETAddContactsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (nonatomic,strong) UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@property (nonatomic,weak) id <ETAddContactsCellDelegate> delegate;

@property (nonatomic,strong) NSIndexPath *rowPath;

@end

NS_ASSUME_NONNULL_END
