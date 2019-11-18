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
        self.layer.cornerRadius = 15;
        WEAK_SELF(self);
        self.bannerView = [[KJBannerView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_WIDTH*0.4)];
        self.bannerView.imgCornerRadius = 15;
        self.bannerView.autoScrollTimeInterval = 2;
        self.bannerView.isZoom = YES;
        self.bannerView.itemSpace = -10;
        self.bannerView.itemWidth = SCREEN_WIDTH-20;
        self.bannerView.imageType = KJBannerViewImageTypeMix;
//        NSString *gif = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564463770360&di=c93e799328198337ed68c61381bcd0be&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20170714%2F1eed483f1874437990ad84c50ecfc82a_th.jpg";
//        self.bannerView.imageDatas = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573820843997&di=d82e372435a4025cba81c6fb16d83540&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2017%2F1214%2F756F54079DFC35207C23E6FE1AA1BC2CA1018BB6_size70_w600_h450.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573820860928&di=5150b930f67ddb9fb0119b5b5d11729c&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F41602924fbab86ce142f11de937ec963f6d55739ea6a-7Hx1E8_fw658"
//                               ];
        [self addSubview:self.bannerView];
        
        self.bannerView.kSelectBlock = ^(KJBannerView * _Nonnull banner, NSInteger idx) {
            NSLog(@"---------%@,%ld",banner,idx);
        };
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.font = [UIFont systemFontOfSize:16];
        titleLb.textColor = UIColorFromHEX(0x333333, 1);
        titleLb.text = @"我的DApp";
        [self addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.equalTo(self.mas_left).offset(33);
            make.top.equalTo(self.bannerView.mas_bottom).offset(20);
            
            
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
        
        UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
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
    
    return self.dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ETFoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ETFoundCell" forIndexPath:indexPath];
    FoundDapp *data = self.dataArr[indexPath.item];
    cell.titleLb.text = data.name;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:data.img]];
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
- (void)setDataArr:(NSMutableArray *)dataArr {
    
    _dataArr = dataArr;
    [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FoundDapp *data = self.dataArr[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(ETFoundHeaderViewDelegateCollectionClick:)]) {
        [self.delegate ETFoundHeaderViewDelegateCollectionClick:data];
    }
}

//- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
//
//    self.collectionView.frame = CGRectMake(0, 0, targetSize.width, MAXFLOAT);
//    return [self.collectionView.collectionViewLayout collectionViewContentSize];
//
//}

@end
