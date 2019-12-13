//
//  ETDirectCountCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/29.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETDirectCountCell.h"

@interface ETDirectCountCell()<UITextFieldDelegate>


@end


@implementation ETDirectCountCell
- (IBAction)coninTypeClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(ETDirectCountCellDelegateCoinClick)]) {
        [self.delegate ETDirectCountCellDelegateCoinClick];
    }
    
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
    self.textfiled.delegate = self;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //        //第一个参数，被替换字符串的range，第二个参数，即将键入或者粘贴的string，返回的是改变过后的新str，即textfield的新的文本内容
    
    NSString *oldText = textField.text;
    NSString *checkStr = [oldText stringByReplacingCharactersInRange:range withString:string];
    if (checkStr.length == 0) {
        return YES;
    }
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isValid = [predicte evaluateWithObject:checkStr];
    return isValid;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
