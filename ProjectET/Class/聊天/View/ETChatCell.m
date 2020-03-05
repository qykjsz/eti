//
//  ETChatCell.m
//  ProjectET
//
//  Created by mac on 2019/12/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETChatCell.h"

@implementation ETChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ETChatLishcChatsModel *)model{
    _model = model;
    if ([model.type isEqualToString:@"2"]) {
        self.lab_titleImg.text = [model.qname substringToIndex:1];
        self.lab_name.text = model.qname;
        self.img_img.image = [UIImage imageNamed:@""];
        
    }else {
        [self.img_img sd_setImageWithURL: [NSURL URLWithString:model.phone]];
        self.lab_titleImg.text = @"";
        self.lab_name.text = model.fromwhoname;
    }
    
     self.lab_time.text = [Tools dateToString: [NSDate dateWithTimeIntervalSince1970:[model.time intValue]]];
    self.lab_mas.text = model.text;
}

-(void)setFriendModel:(ETChatLishAddfriendModel *)friendModel{
    _friendModel = friendModel;
    self.lab_name.text = @"好友通知";
    self.lab_titleImg.text = @"";
    if (![friendModel.name isEqualToString:@""]) {
        self.lab_mas.text = [NSString stringWithFormat:@"%@ 请求加你为好友",friendModel.name];
         self.lab_time.text = [Tools dateToString: [NSDate dateWithTimeIntervalSince1970:[friendModel.time intValue]]];
    }else {
        self.lab_mas.text = @"";
        self.lab_time.text = @"";
    }
    
   
     self.img_img.image = [UIImage imageNamed:@"haoyou"];
}

-(void)setGroupModel:(ETChatLishAddgroupModel *)groupModel{
    _groupModel = groupModel;
    self.lab_name.text = @"群通知";
    self.lab_titleImg.text = @"";
    if (![groupModel.name isEqualToString:@""]) {
        self.lab_mas.text = [NSString stringWithFormat:@"%@ 请求加入 %@",groupModel.name,groupModel.qname];
        self.lab_time.text = [Tools dateToString: [NSDate dateWithTimeIntervalSince1970:[groupModel.time intValue]]];
    }else {
        self.lab_mas.text = @"";
        self.lab_time.text = @"";
    }
    
   
    self.img_img.image = [UIImage imageNamed:@"icon_notice"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
