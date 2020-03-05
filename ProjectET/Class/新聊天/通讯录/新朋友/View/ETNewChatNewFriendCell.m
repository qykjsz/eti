//
//  ETNewChatNewFriendCell.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatNewFriendCell.h"

@implementation ETNewChatNewFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ETNewChatNewFriendDataModel *)model{
    _model = model;
    [self.img_img sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    if (![model.remarks isEqualToString:@""]) {
        self.lab_remark.text = [NSString stringWithFormat:@"%@",model.remarks];
    }
    self.lab_name.text = model.name;
    if ([model.state isEqualToString:@"1"]) {
        [self.btn_agree setHidden:false];
        [self.btn_cancel setHidden:false];
        [self.lab_mas setHidden:true];
    }else if ([model.state isEqualToString:@"2"]) {
        [self.btn_agree setHidden:true];
        [self.btn_cancel setHidden:true];
        [self.lab_mas setHidden:false];
        self.lab_mas.text = @"已通过";
    }else if ([model.state isEqualToString:@"3"]) {
        [self.btn_agree setHidden:true];
        [self.btn_cancel setHidden:true];
        [self.lab_mas setHidden:false];
        self.lab_mas.text = @"已拒绝";
    }
}

///同意
- (IBAction)actionOfAgree:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ETNewChatNewFriendCellAgreeDelegate:)]) {
                [self.delegate ETNewChatNewFriendCellAgreeDelegate:self.model.ID];
           }
    
}

///拒绝
- (IBAction)actionOfCancel:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ETNewChatNewFriendCellCancelDelegate:)]) {
         [self.delegate ETNewChatNewFriendCellCancelDelegate:self.model.ID];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
