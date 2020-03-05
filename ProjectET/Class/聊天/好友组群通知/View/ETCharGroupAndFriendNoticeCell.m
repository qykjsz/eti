//
//  ETCharGroupAndFriendNoticeCell.m
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETCharGroupAndFriendNoticeCell.h"

@implementation ETCharGroupAndFriendNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setFriendModel:(ETCharGroupAndFriendNoticeListModel *)friendModel{
    _friendModel = friendModel;
    self.lab_name.text = [NSString stringWithFormat:@"%@",friendModel.name];
    self.lab_msg.text = @"请求添加您为好友";
    self.lab_operation.text = @"";
    self.lab_imgTitle.text = @"";
    
    if ([friendModel.state isEqualToString:@"1"]) {
        self.lab_state.text = @"";
        [self.btn_agree setHidden:NO];
        [self.btn_refused setHidden:NO];
    }else  if ([friendModel.state isEqualToString:@"2"]) {
        self.lab_state.text = @"已同意";
        self.lab_state.textColor = UIColorFromHEX(0x1D57FF, 1);
        [self.btn_agree setHidden:YES];
        [self.btn_refused setHidden:YES];
    }else if ([friendModel.state isEqualToString:@"3"]) {
        self.lab_state.text = @"已拒绝";
        self.lab_state.textColor = UIColorFromHEX(0xB7BCDC, 1);
        [self.btn_agree setHidden:YES];
        [self.btn_refused setHidden:YES];
    }
    [self.img_img sd_setImageWithURL:[NSURL URLWithString:friendModel.phone]];
    
}

- (void)setGroupModel:(ETCharGroupAndFriendNoticeListModel *)groupModel{
    _groupModel = groupModel;
    self.lab_name.text = [NSString stringWithFormat:@"%@",groupModel.name];
    self.lab_msg.text = [NSString stringWithFormat:@"申请加入 %@",groupModel.qname];
    self.lab_imgTitle.text = [groupModel.qname substringToIndex:1];
    self.img_img.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    if ([groupModel.state isEqualToString:@"1"]) {
        self.lab_state.text = @"";
        [self.btn_agree setHidden:NO];
        [self.btn_refused setHidden:NO];
            self.lab_operation.text = @"";
    }else  if ([groupModel.state isEqualToString:@"2"]) {
        self.lab_state.text = @"已同意";
        self.lab_state.textColor = UIColorFromHEX(0x1D57FF, 1);
        [self.btn_agree setHidden:YES];
        [self.btn_refused setHidden:YES];
        self.lab_operation.text = [NSString stringWithFormat:@"处理人:%@",groupModel.operation];
    }else if ([groupModel.state isEqualToString:@"3"]) {
        self.lab_state.text = @"已拒绝";
        self.lab_state.textColor = UIColorFromHEX(0xB7BCDC, 1);
        [self.btn_agree setHidden:YES];
        [self.btn_refused setHidden:YES];
        self.lab_operation.text = [NSString stringWithFormat:@"处理人:%@",groupModel.operation];
    }
//    [self.img_img sd_setImageWithURL:[NSURL URLWithString:groupModel.phone]];
}

///同意
- (IBAction)actionOfAgree:(UIButton *)sender {
    if (self.friendModel != nil) {
        if ([self.delegate respondsToSelector:@selector(ETCharGroupAndFriendNoticeAgreeDelegate:AndQCode:)]) {
                [self.delegate ETCharGroupAndFriendNoticeAgreeDelegate:self.friendModel.Id AndQCode:@""];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(ETCharGroupAndFriendNoticeAgreeDelegate:AndQCode:)]) {
            [self.delegate ETCharGroupAndFriendNoticeAgreeDelegate:self.groupModel.Id AndQCode:self.groupModel.qcode];
        }
    }
}

///拒绝
- (IBAction)actionOfRefused:(UIButton *)sender {
    if (self.friendModel != nil) {
        if ([self.delegate respondsToSelector:@selector(ETCharGroupAndFriendNoticeRefusedDelegate:AndQCode:)]) {
                [self.delegate ETCharGroupAndFriendNoticeRefusedDelegate:self.friendModel.Id AndQCode:@""];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(ETCharGroupAndFriendNoticeRefusedDelegate:AndQCode:)]) {
                [self.delegate ETCharGroupAndFriendNoticeRefusedDelegate:self.groupModel.Id AndQCode:self.groupModel.qcode];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
