//
//  ETCreatWalletInputCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETCreatWalletInputCell.h"

@implementation ETCreatWalletInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = UIColorFromHEX(0xE6E6E6, 1);
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.hideBtn setImage:[UIImage imageNamed:@"key_xian"] forState:UIControlStateSelected];
    
    [self.textfiled addTarget:self action:@selector(textfiledDidchange:) forControlEvents:UIControlEventEditingChanged];
    
    
}

- (void)textfiledDidchange:(UITextField *)textfiled {
    
    if ([self.delegate respondsToSelector:@selector(ETCreatWalletInputCellDelegateTextfied:rowPath:)]) {
        [self.delegate ETCreatWalletInputCellDelegateTextfied:textfiled rowPath:self.rowPath];
    }
    
}


- (IBAction)clickAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    
    if (self.securEntyBlock) {
        self.securEntyBlock(btn.selected, self.rowPath);
    }
    
    if ([self.delegate respondsToSelector:@selector(ETCreatWalletInputCellDelegateTextfiedSecuentry:)]) {
        [self.delegate ETCreatWalletInputCellDelegateTextfiedSecuentry:btn.selected];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
