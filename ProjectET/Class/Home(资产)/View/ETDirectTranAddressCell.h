//
//  ETDirectTranAddressCell.h
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETDirectTranAddressCellDelegate <NSObject>

- (void)ETDirectTranAddressCellDelegateAddressClick;

- (void)ETDirectTranAddressCellDelegateTextfiled:(UITextField *)textfiled;

@end

@interface ETDirectTranAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (weak, nonatomic) id <ETDirectTranAddressCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
