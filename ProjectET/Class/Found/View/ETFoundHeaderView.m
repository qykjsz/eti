//
//  ETFoundHeaderView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundHeaderView.h"
#import "ETFoundCell.h"
@interface ETFoundHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ETFoundHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 25;
        WEAK_SELF(self);
        UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fx_banner"]];
        [self addSubview:topImage];
        [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(20);
            make.right.equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(150);
            
        }];
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.font = [UIFont systemFontOfSize:16];
        titleLb.textColor = UIColorFromHEX(0x333333, 1);
        titleLb.text = @"我的DApp";
        [self addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.equalTo(self.mas_left).offset(33);
            make.top.equalTo(topImage.mas_bottom).offset(20);
            
            
        }];
        
        UIView *dapp1 = [[UIView alloc]init];
        [self addSubview:dapp1];
        [dapp1 mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.equalTo(self.mas_left).offset(30);
            make.width.mas_equalTo(64);
            make.height.mas_equalTo(80);
            make.top.equalTo(titleLb.mas_bottom).offset(5);
            
        }];
        
        UIImageView *dappImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fx_01"]];
        [dapp1 addSubview:dappImage];
        [dappImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.centerX.equalTo(dapp1.mas_centerX);
            make.width.height.mas_equalTo(44);
            make.top.equalTo(dapp1.mas_top).offset(10);
            
        }];
        
        UILabel *dapp1Lb = [[UILabel alloc]init];
        dapp1Lb.font = [UIFont systemFontOfSize:11];
        dapp1Lb.textColor = UIColorFromHEX(0x333333, 1);
        dapp1Lb.text = @"猎鱼达人";
        dapp1Lb.textAlignment = NSTextAlignmentCenter;
        [dapp1 addSubview:dapp1Lb];
        [dapp1Lb mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.right.equalTo(dapp1);
            make.top.equalTo(dappImage.mas_bottom).offset(10);
            
        }];
        
        UIView *dapp2 = [[UIView alloc]init];
        [self addSubview:dapp2];
        [dapp2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(dapp1.mas_right).offset(5);
            make.width.mas_equalTo(64);
            make.height.mas_equalTo(80);
            make.top.equalTo(titleLb.mas_bottom).offset(5);
            
        }];
        
        UIImageView *dappImage2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fa_02"]];
        [dapp1 addSubview:dappImage2];
        [dappImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
            

            make.centerX.equalTo(dapp2.mas_centerX);
            make.width.height.mas_equalTo(44);
            make.top.equalTo(dapp2.mas_top).offset(10);
            
        }];
        
        UILabel *dapp2Lb = [[UILabel alloc]init];
        dapp2Lb.font = [UIFont systemFontOfSize:11];
        dapp2Lb.textColor = UIColorFromHEX(0x333333, 1);
        dapp2Lb.text = @"即可金服";
        dapp2Lb.textAlignment = NSTextAlignmentCenter;
        [dapp2 addSubview:dapp2Lb];
        [dapp2Lb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(dapp2);
            make.top.equalTo(dappImage2.mas_bottom).offset(10);
            
        }];
        
        UILabel *titleLb2 = [[UILabel alloc]init];
        titleLb2.font = [UIFont systemFontOfSize:16];
        titleLb2.textColor = UIColorFromHEX(0x333333, 1);
        titleLb2.text = @"精选DApp";
        [self addSubview:titleLb2];
        [titleLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.equalTo(self.mas_left).offset(33);
            make.top.equalTo(dapp1.mas_bottom).offset(20);
            
            
        }];
        
        UILabel *subTitle = [[UILabel alloc]init];
        subTitle.font = [UIFont systemFontOfSize:12];
        subTitle.textColor = UIColorFromHEX(0x999999, 1);
        subTitle.text = @"官方精选，不容错过";
        [self addSubview:subTitle];
        [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.centerY.equalTo(titleLb2.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-15);
            
        }];
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        self.collectionView.backgroundColor = UIColor.whiteColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[ETFoundCell class] forCellWithReuseIdentifier:@"ETFoundCell"];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.equalTo(self);
            make.top.equalTo(titleLb2.mas_bottom).offset(10);
            make.height.mas_equalTo(100);
            
        }];

        
    }
    return self;
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ETFoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ETFoundCell" forIndexPath:indexPath];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(64, 80);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 30, 0, 0);
    
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 3;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;


@end
