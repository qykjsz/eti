//
//  ETAddContactsCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETAddContactsCell.h"

@implementation ETAddContactsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLb.textColor = UIColorFromHEX(0x000000, 1);
    
    self.scanBtn = [[UIButton alloc]init];
    [self.scanBtn setImage:[UIImage imageNamed:@"zjc_sao"] forState:UIControlStateNormal];
    [self.scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.scanBtn];
    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.height.mas_equalTo(18);
        
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = UIColorFromHEX(0xE6E6E6, 1);
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.textfiled addTarget:self action:@selector(textfiledDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)textfiledDidChange:(UITextField *)filed {
    
    if ([self.delegate respondsToSelector:@selector(ETAddContactsCellDelegateTextfiled:rowPath:)]) {
        [self.delegate ETAddContactsCellDelegateTextfiled:filed rowPath:self.rowPath];
    }
}

- (void)scanAction {
    
    if ([self.delegate respondsToSelector:@selector(ETAddContactsCellDelegateScanClick)]) {
        [self.delegate ETAddContactsCellDelegateScanClick];
    }
    
}


@end
