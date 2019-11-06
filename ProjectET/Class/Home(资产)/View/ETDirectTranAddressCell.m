//
//  ETDirectTranAddressCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETDirectTranAddressCell.h"

@implementation ETDirectTranAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLb.textColor = UIColorFromHEX(0x000000, 1);
    self.textfield.placeholder = @"请输入或粘贴钱包地址";
    
    [self.textfield addTarget:self action:@selector(textfieldDidchange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = UIColorFromHEX(0xE6E6E6, 1);
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)textfieldDidchange:(UITextField *)textfiled {
    
    if ([self.delegate respondsToSelector:@selector(ETDirectTranAddressCellDelegateTextfiled:)]) {
        [self.delegate ETDirectTranAddressCellDelegateTextfiled:textfiled];
    }
}


- (IBAction)clickAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(ETDirectTranAddressCellDelegateAddressClick)]) {
        [self.delegate ETDirectTranAddressCellDelegateAddressClick];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
