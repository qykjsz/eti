//
//  ViewController.m
//  ETDemon
//
//  Created by hufeng on 2019/10/28.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ViewController.h"
#import "EqualSpaceFlowLayoutEvolve.h"
#import "titleCell.h"
#import "backUpViewController.h"
#import "ViewController.h"
#import "ETRootViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionView *topCollectionView;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableArray *topArray;

@end

@implementation ViewController

- (NSArray *)randamArry:(NSArray *)arry
{
    // 对数组乱序
    arry = [arry sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    
    return arry;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    
    self.array = [[NSMutableArray alloc]init];
    [self.array addObjectsFromArray:[self randamArry:model.mnemonicPhrase]];

    
    self.topArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"确认助记词";

    
    UILabel *tipsLb = [[UILabel alloc]init];
    tipsLb.text = @"请确认你的钱包助记词";
    tipsLb.font = [UIFont systemFontOfSize:16];
    tipsLb.textColor = UIColorFromHEX(0x000000, 1);
    tipsLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipsLb];
    
    UILabel *subTitle = [[UILabel alloc] init];
    subTitle.text = @"请按抄写的顺序点击助记词，确认你的备份助记词正确";
    subTitle.font = [UIFont systemFontOfSize:14];
    subTitle.textColor = UIColorFromHEX(0x999999, 1);
    subTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:subTitle];
    
    [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(80);
        
    }];
    
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(tipsLb.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        
    }];
    
    [self.view addSubview:self.topCollectionView];
    
    [self.topCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(subTitle.mas_bottom).offset(10);
        make.height.mas_equalTo(150);
        
    }];
    
    [self.view addSubview:self.collectionView];
   
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.topCollectionView.mas_bottom).offset(20);
        
    }];
    
    
    UIButton *clickBtn = [[UIButton alloc] init];
    [clickBtn setTitle:@"完成" forState:UIControlStateNormal];
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


#pragma mark - Action
- (void)clickAction {
    
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    for (int i = 0; i<self.array.count; i++) {
        
        NSString *name = model.mnemonicPhrase[i];
        NSString *tempName = self.array[i];
        
        if (name != tempName) {
            [KMPProgressHUD showText:@"两次顺序不一样，请重新选择"];
            return;
        }
    }
    
    model.isBackUp = YES;
    
    [ETWalletManger updateWallet:model];
    
    [KMPProgressHUD showText:@"备份成功"];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = [ETRootViewController new];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.topCollectionView) {
        return self.topArray.count;
    }else {
        return self.array.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == self.topCollectionView) {
        titleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
        cell.titleLb.text = self.topArray[indexPath.row];
        return cell;
    }else {
        titleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
        cell.titleLb.text = self.array[indexPath.row];
        return cell;
    }
   
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.topCollectionView) {
        
        [self.array addObject:self.topArray[indexPath.row]];
        [self.topArray removeObjectAtIndex:indexPath.row];
        [self.topCollectionView reloadData];
        [self.collectionView reloadData];
        
    }else {
       
        [self.topArray addObject:self.array[indexPath.row]];
        [self.array removeObjectAtIndex:indexPath.row];
        [self.topCollectionView reloadData];
        [self.collectionView reloadData];
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
    
    if (collectionView == self.topCollectionView) {
        title = self.topArray[indexPath.row];
    }else {
       title = self.array[indexPath.row];
    }

    CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    return CGSizeMake(textSize.width+20, 30);

}

#pragma mark - get&set
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        EqualSpaceFlowLayoutEvolve * flowLayout = [[EqualSpaceFlowLayoutEvolve alloc]initWthType:AlignWithCenter];
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

- (UICollectionView *)topCollectionView
{
    if (_topCollectionView == nil) {
        EqualSpaceFlowLayoutEvolve * flowLayout = [[EqualSpaceFlowLayoutEvolve alloc]initWthType:AlignWithCenter];
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 30, 10, 40);
        flowLayout.cellType = AlignWithLeft;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _topCollectionView.layer.shadowColor = UIColorFromHEX(0x002793, 1).CGColor;
        _topCollectionView.layer.shadowOffset = CGSizeMake(3, 3);
        _topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _topCollectionView.backgroundColor = [UIColor whiteColor];
        _topCollectionView.delegate = self;
        _topCollectionView.dataSource = self;
        _topCollectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kj_kp_d"]];
        [_topCollectionView registerClass:[titleCell class] forCellWithReuseIdentifier:@"titleCell"];
        
    }
    return _topCollectionView;
}

@end
