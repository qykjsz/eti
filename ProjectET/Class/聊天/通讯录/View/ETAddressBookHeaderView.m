//
//  ETAddressBookHeaderView.m
//  ProjectET
//
//  Created by mac on 2020/1/3.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETAddressBookHeaderView.h"

@implementation ETAddressBookHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *contenView = [[NSBundle mainBundle]loadNibNamed:@"ETAddressBookHeaderView" owner:self options:nil].lastObject;
        contenView.frame = frame;
        [self.tf_name setEnabled:false];
        [self addSubview:contenView];
    }
    return self;
}
- (IBAction)actionTextFieldEditingChanged:(UITextField *)sender {
    if (sender.text.length >= 10) {
        sender.text = [sender.text substringToIndex:10];
    }
}

///修改头像
- (IBAction)actionOfChangeHeaderImg:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ETAddressBookHeaderViewChangeHeaderImgDelegate)]) {
       [self.delegate ETAddressBookHeaderViewChangeHeaderImgDelegate];
      }
}

///二维码
- (IBAction)actionOfCode:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(ETAddressBookHeaderViewUserInfoCodeDelegate)]) {
        [self.delegate ETAddressBookHeaderViewUserInfoCodeDelegate];
       }
}

///编辑
- (IBAction)actionOfEdit:(UIButton *)sender {
    [self.btn_edit setHidden:YES];
    [self.btn_sure setHidden:NO];
    self.view_nameBg.backgroundColor = UIColorFromHEX(0xF5F5F5, 1);
    [self.tf_name setEnabled:YES];
}

///好友
- (IBAction)actionOfFriend:(UIButton *)sender {
    [self.btn_friend setEnabled:false];
    self.btn_friend.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_group setEnabled:true];
    self.btn_group.titleLabel.font = [UIFont systemFontOfSize:14];
    if ([self.delegate respondsToSelector:@selector(ETAddressBookHeaderViewFriendAndGroupDelegate:)]) {
        [self.delegate ETAddressBookHeaderViewFriendAndGroupDelegate:1];
    }
}

///组群
- (IBAction)actionOfGroup:(UIButton *)sender {
    [self.btn_group setEnabled:false];
    self.btn_group.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_friend setEnabled:true];
    self.btn_friend.titleLabel.font = [UIFont systemFontOfSize:14];
    if ([self.delegate respondsToSelector:@selector(ETAddressBookHeaderViewFriendAndGroupDelegate:)]) {
        [self.delegate ETAddressBookHeaderViewFriendAndGroupDelegate:2];
    }
}

- (IBAction)actionOfSure:(UIButton *)sender {
    [self.btn_edit setHidden:NO];
    [self.btn_sure setHidden:YES];
    self.view_nameBg.backgroundColor = UIColor.whiteColor;
    [self.tf_name setEnabled:NO];
    if ([self.delegate respondsToSelector:@selector(ETAddressBookHeaderViewChangeNameDelegate:)]) {
        [self.delegate ETAddressBookHeaderViewChangeNameDelegate:self.tf_name.text];
       }
}

///搜索
- (IBAction)actionOfSearchChanged:(UITextField *)sender {
    if ([self.delegate respondsToSelector:@selector(ETAddressBookHeaderViewSearchDelegate:)]) {
           [self.delegate ETAddressBookHeaderViewSearchDelegate:self.tf_search.text];
          }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
