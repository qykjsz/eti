//
//  backUpViewController.m
//  ETDemon
//
//  Created by hufeng on 2019/10/28.
//  Copyright © 2019 LightCould. All rights reserved.
//


#import "backUpViewController.h"
#import "EqualSpaceFlowLayoutEvolve.h"
#import "Masonry.h"
#import "titleCell.h"
#import "ViewController.h"
@interface backUpViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *array;


@end

@implementation backUpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"备份助记词";
    self.view.backgroundColor = UIColor.whiteColor;
    ETWalletModel *arr = [ETWalletManger getCurrentWallet];
    self.array = [[NSMutableArray alloc]init];
    [self.array addObjectsFromArray:arr.mnemonicPhrase];
    
//    [self.array addObject:@"very"];
//    [self.array addObject:@"sunny"];
//    [self.array addObject:@"harsh"];
//    [self.array addObject:@"member"];
//    [self.array addObject:@"child"];
//    [self.array addObject:@"final"];
//    [self.array addObject:@"bag"];
//    [self.array addObject:@"village"];
//    [self.array addObject:@"impose"];
//    [self.array addObject:@"visual"];
//    [self.array addObject:@"blue"];
//    [self.array addObject:@"visual"];
    
    UILabel *tipsLb = [[UILabel alloc]init];
    tipsLb.text = @"请确认你的钱包助记词";
    tipsLb.font = [UIFont systemFontOfSize:16];
    tipsLb.textColor = UIColorFromHEX(0x000000, 1);
    tipsLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipsLb];
    
    UILabel *subTitle = [[UILabel alloc] init];
    subTitle.text = @"请准确抄写并安全保存助记词";
    subTitle.font = [UIFont systemFontOfSize:14];
    subTitle.textColor = UIColorFromHEX(0x999999, 1);
    subTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:subTitle];
    
    [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(144);
        
    }];
    
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(tipsLb.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        
    }];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(subTitle.mas_bottom).offset(20);
        
    }];
    
    
    UIButton *clickBtn = [[UIButton alloc] init];
    [clickBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [clickBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    clickBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    clickBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    clickBtn.clipsToBounds = YES;
    clickBtn.layer.cornerRadius = 5;
    [clickBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.height.mas_equalTo(44);
        
    }];
}

- (void)clickAction {
    
    ViewController *bcVC = [ViewController new];
    [self.navigationController pushViewController:bcVC animated:YES];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.array.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        titleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
        cell.titleLb.text = self.array[indexPath.row];
        return cell;

}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

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

    title = self.array[indexPath.row];
    
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    return CGSizeMake(textSize.width+20, 30);
    
}

#pragma mark - get&set
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        EqualSpaceFlowLayoutEvolve * flowLayout = [[EqualSpaceFlowLayoutEvolve alloc]initWthType:AlignWithCenter];
        flowLayout.cellType = AlignWithLeft;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[titleCell class] forCellWithReuseIdentifier:@"titleCell"];
        
    }
    return _collectionView;
}


@end
