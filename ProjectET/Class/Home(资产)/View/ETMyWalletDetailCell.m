//
//  ETMyWalletDetailCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETMyWalletDetailCell.h"

@implementation ETMyWalletDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.topleftLb.textColor = UIColorFromHEX(0x1D57FF, 1);
    self.topleftLb.backgroundColor = UIColor.whiteColor;
    self.topleftLb.text = @"当前";
    
    [self.statusBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.statusBtn.clipsToBounds = YES;
    self.statusBtn.layer.borderColor = UIColor.whiteColor.CGColor;
    self.statusBtn.layer.borderWidth = 1;
    self.statusBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    
    self.walletName.textColor = UIColor.whiteColor;
    
    self.bottoLb.textColor = UIColorFromHEX(0xB7BCDC, 1);
    
}

- (void)setModel:(ETWalletModel *)model {
    
    _model = model;
    
    self.walletName.text = model.walletName;
    self.bottoLb.text = model.address;
    
    if (model.isBackUp) {
        [self.statusBtn setTitle:@"不可备份" forState:UIControlStateNormal];
    }else {
        [self.statusBtn setTitle:@"不可备份" forState:UIControlStateNormal];
    }
    
    if (model.isCurrentWallet) {
        self.topleftLb.hidden = NO;
        self.topLbWidth.constant = 32;
        self.statusBtnLeftSpace.constant = 15;
    }else {
        self.statusBtnLeftSpace.constant = 0;
        self.topLbWidth.constant = 0;
        self.topleftLb.hidden = YES;
    }
    
}

- (IBAction)clickAction:(id)sender {
    
    [Tools copyClickWithText:self.model.address];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
