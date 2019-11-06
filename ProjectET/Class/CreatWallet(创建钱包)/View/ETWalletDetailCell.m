//
//  ETWalletDetailCell.m
//  ProjectET
//
//  Created by hufeng on 2019/11/2.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETWalletDetailCell.h"

@implementation ETWalletDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.detailLb.textColor = UIColorFromHEX(0x000000, 1);
    
    self.arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zc_yjt"]];
    [self.contentView addSubview:self.arrowImage];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = UIColorFromHEX(0xEBEBEB, 1);
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.equalTo(@0.5);
        
    }];
}
- (IBAction)copyAction:(id)sender {

    [Tools copyClickWithText:self.detailLb.text];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
