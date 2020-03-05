//
//  ETAddressBookHeaderView.h
//  ProjectET
//
//  Created by mac on 2020/1/3.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETAddressBookHeaderViewDelegate <NSObject>

- (void)ETAddressBookHeaderViewFriendAndGroupDelegate:(NSInteger)type;

- (void)ETAddressBookHeaderViewChangeNameDelegate:(NSString *)name;

- (void)ETAddressBookHeaderViewChangeHeaderImgDelegate;

- (void)ETAddressBookHeaderViewUserInfoCodeDelegate;

- (void)ETAddressBookHeaderViewSearchDelegate:(NSString *)address;

@end

@interface ETAddressBookHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn_edit;
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UIButton *btn_friend;
@property (weak, nonatomic) IBOutlet UIButton *btn_group;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;
@property (weak, nonatomic) IBOutlet UIView *view_nameBg;
@property (nonatomic,weak) id <ETAddressBookHeaderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *tf_search;

@end

NS_ASSUME_NONNULL_END
