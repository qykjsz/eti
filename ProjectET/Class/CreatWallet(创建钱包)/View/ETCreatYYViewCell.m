//
//  ETCreatYYViewCell.m
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETCreatYYViewCell.h"
#import "UIButton+ImageTitleSpacing.h"

@interface ETCreatYYViewCell()<YYTextViewDelegate>

@end

@implementation ETCreatYYViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    

    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textView = [[YYTextView alloc]init];
        [self.contentView addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            
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
        
        self.clickBtn = [[UIButton alloc]init];
        self.clickBtn.hidden = YES;
        self.clickBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [self.clickBtn setImage:[UIImage imageNamed:@"lqb_yao"] forState:UIControlStateNormal];
        [self.clickBtn setTitle:@"密钥生成器" forState:UIControlStateNormal];
        [self.clickBtn setTitleColor:UIColorFromHEX(0x2B80F4, 1) forState:UIControlStateNormal];
        [self.clickBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.clickBtn];
        [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.right.equalTo(self.contentView);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(35);
            
        }];
        
         [self.clickBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        
        self.textView.delegate = self;
        
    }
    
    return self;
}


#pragma mark -
- (void)textViewDidChange:(YYTextView *)textView {
    
    if ([self.delegate respondsToSelector:@selector(ETCreatYYViewCellDelegateTextView:)]) {
        [self.delegate ETCreatYYViewCellDelegateTextView:textView];
    }
}


- (void)clickAction {
   
    
    if ([self.delegate respondsToSelector:@selector(ETCreatYYViewCellDelegateSecertClick)]) {
        [self.delegate ETCreatYYViewCellDelegateSecertClick];
    }
}

@end
