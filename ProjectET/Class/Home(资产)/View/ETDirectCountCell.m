//
//  ETDirectCountCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETDirectCountCell.h"



@implementation ETDirectCountCell
- (IBAction)coninTypeClick:(id)sender {
    
}
- (IBAction)allClickAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(ETDirectCountCellDelegateFullCoinClick)]) {
        [self.delegate ETDirectCountCellDelegateFullCoinClick];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLb.textColor = UIColorFromHEX(0x000000, 1);
    self.textfiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.coninBtn setTitleColor:UIColorFromHEX(0x000000, 1) forState:UIControlStateNormal];
    self.allBtn.clipsToBounds = YES;
    self.allBtn.layer.borderColor = UIColorFromHEX(0x1D57FF, 1).CGColor;
    self.allBtn.layer.borderWidth = 1;
    self.allBtn.layer.cornerRadius = 10;
    [self.allBtn setTitleColor:UIColorFromHEX(0x1D57FF, 1) forState:UIControlStateNormal];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = UIColorFromHEX(0xE6E6E6, 1);
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.textfiled addTarget:self action:@selector(textfieldDidchange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textfieldDidchange:(UITextField *)textfiled {
    
    if ([self.delegate respondsToSelector:@selector(ETDirectCountCellDelegateTextField:)]) {
        [self.delegate ETDirectCountCellDelegateTextField:textfiled];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
