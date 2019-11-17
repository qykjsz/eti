//
//  ETFoundSearchCollectionView.m
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundSearchCollectionView.h"
#import "titleCell.h"
#import "EqualSpaceFlowLayoutEvolve.h"

@interface ETFoundSearchCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ETFoundSearchCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *topLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rementuijian"]];
        [self addSubview:topLeftImage];
        WEAK_SELF(self);
        [topLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.top.equalTo(self).offset(15);
            make.height.width.mas_equalTo(16);
            
        }];
        
        UILabel *tipsLb = [[UILabel alloc]init];
        tipsLb.text = @"热门推荐";
        tipsLb.font = [UIFont systemFontOfSize:14];
        tipsLb.textColor = UIColorFromHEX(0x999999, 1);
        [self addSubview:tipsLb];
        [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(topLeftImage.mas_centerY);
            make.left.equalTo(topLeftImage.mas_right).offset(15);
            
        }];
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            STRONG_SELF(self);
            make.left.right.equalTo(self);
            make.top.equalTo(topLeftImage.mas_bottom).offset(5);
            make.height.mas_equalTo(80);
            
        }];
        
        
    }
    
    return self;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
    return self.dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    titleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell"forIndexPath:indexPath];
    cell.titleLb.clipsToBounds = YES;
    cell.titleLb.layer.cornerRadius = 5;
    cell.titleLb.text = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *text = self.dataArr[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(ETFoundSearchCollectionViewDelegateClick:)]) {
        [self.delegate ETFoundSearchCollectionViewDelegateClick:text];
    }
}

//上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//行间距 每个section items 左右行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *title = nil;
    

    title = self.dataArr[indexPath.row];
    
    
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    return CGSizeMake(textSize.width+20, 25);
    
}

#pragma mark - get&set
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        EqualSpaceFlowLayoutEvolve * flowLayout = [[EqualSpaceFlowLayoutEvolve alloc]initWthType:AlignWithLeft];
        flowLayout.cellType = AlignWithLeft;
        //flowLayout.betweenOfCell = 15;
        // flowLayout.sectionInset = UIEdgeInsetsMake(10, 30, 10, 30);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[titleCell class] forCellWithReuseIdentifier:@"titleCell"];
        
    }
    return _collectionView;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    
    _dataArr = dataArr;
    [self.collectionView reloadData];
    
}

@end
