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

@property (nonatomic,strong) UICollectionView *collectionView2;


@end

@implementation ETFoundHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15;
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height)];
        backView.backgroundColor = UIColor.whiteColor;
        [self addSubview:backView];
         WEAK_SELF(self);
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {

            STRONG_SELF(self);
            make.edges.equalTo(self);

        }];
        
//        UITableView *detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//        detailTab.delegate = self;
//        detailTab.dataSource = self;
//        detailTab.separatorStyle = UITableViewCellSelectionStyleNone;
//        [detailTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"123"];
//        detailTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//            STRONG_SELF(self);
//            [detailTab.mj_header endRefreshing];
//
//        }];
//        [self addSubview:detailTab];
//        [detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            STRONG_SELF(self);
//            make.edges.equalTo(self);
//
//        }];
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
        [backView addSubview:self.bannerView];
        
        self.bannerView.kSelectBlock = ^(KJBannerView * _Nonnull banner, NSInteger idx) {
            if ([self.delegate respondsToSelector:@selector(ETFoundHeaderViewDelegateBannerClick:)]) {
                [self.delegate ETFoundHeaderViewDelegateBannerClick:idx];
            }
        };
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.font = [UIFont systemFontOfSize:16];
        titleLb.textColor = UIColorFromHEX(0x333333, 1);
        titleLb.text = @"我的DApp";
        [backView addSubview:titleLb];
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.bannerView.mas_bottom).offset(20);
            
            
        }];
        
       
        UICollectionViewFlowLayout *flow2 = [UICollectionViewFlowLayout new];
        self.collectionView2 = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow2];
        self.collectionView2.backgroundColor = UIColor.whiteColor;
        self.collectionView2.delegate = self;
        self.collectionView2.scrollEnabled = false;
        self.collectionView2.dataSource = self;
        [self.collectionView2 registerClass:[ETFoundCell class] forCellWithReuseIdentifier:@"ETFoundCell"];
        [backView addSubview:self.collectionView2];
        [self.collectionView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self);
            make.top.equalTo(titleLb.mas_bottom).offset(10);
            make.height.mas_equalTo(80);
            
        }];
      
        
        UILabel *titleLb2 = [[UILabel alloc]init];
        titleLb2.font = [UIFont systemFontOfSize:16];
        titleLb2.textColor = UIColorFromHEX(0x333333, 1);
        titleLb2.text = @"精选DApp";
        [backView addSubview:titleLb2];
        [titleLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.collectionView2.mas_bottom).offset(20);
            
            
        }];
        
        UILabel *subTitle = [[UILabel alloc]init];
        subTitle.font = [UIFont systemFontOfSize:12];
        subTitle.textColor = UIColorFromHEX(0x999999, 1);
        subTitle.text = @"官方精选，不容错过";
        [backView addSubview:subTitle];
        [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.centerY.equalTo(titleLb2.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-15);
            
        }];
        
        UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
//        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
        self.collectionView.backgroundColor = UIColor.whiteColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.scrollEnabled = false;
        [self.collectionView registerClass:[ETFoundCell class] forCellWithReuseIdentifier:@"ETFoundCell"];
        [backView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.equalTo(self);
            make.top.equalTo(titleLb2.mas_bottom).offset(10);
            make.height.mas_equalTo(100);
            
        }];

        
        
        
    }
    return self;
    
}

-(void)actionOfDapp1{
    if ([self.delegate respondsToSelector:@selector(ETFoundHeaderViewDAppDelegateCollectionClick:)]) {
        [self.delegate ETFoundHeaderViewDAppDelegateCollectionClick:1];
    }
}

-(void)actionOfDapp2{
    if ([self.delegate respondsToSelector:@selector(ETFoundHeaderViewDAppDelegateCollectionClick:)]) {
        [self.delegate ETFoundHeaderViewDAppDelegateCollectionClick:2];
    }
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.collectionView) {
        return self.dataArr.count;
    }else {
        return self.topArr.count;
    }
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.collectionView) {
        ETFoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ETFoundCell" forIndexPath:indexPath];
        FoundDapp *data = self.dataArr[indexPath.item];
        cell.titleLb.text = data.name;
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:data.img]];
        return cell;
    }else {
        ETFoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ETFoundCell" forIndexPath:indexPath];
        FoundDapp *data = self.topArr[indexPath.item];
        cell.titleLb.text = data.name;
        if ([data.img containsString:@"http"]) {
            [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:data.img]];
        }else {
            cell.iconImage.image = [UIImage imageNamed:data.img];
        }
        
        return cell;
    }
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger width = (SCREEN_WIDTH - 30 - 40)/5;
    return CGSizeMake(width, 80);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 15, 0, 15);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.collectionView) {
        FoundDapp *data = self.dataArr[indexPath.item];
        if ([self.delegate respondsToSelector:@selector(ETFoundHeaderViewDelegateCollectionClick:)]) {
            [self.delegate ETFoundHeaderViewDelegateCollectionClick:data];
        }
    }else {
        
        if ([self.delegate respondsToSelector:@selector(ETFoundHeaderViewDAppDelegateCollectionClick:)]) {
            [self.delegate ETFoundHeaderViewDAppDelegateCollectionClick:indexPath.row];
        }
        
    }
    
   
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 1;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    
//    return 1;
//}

- (void)setDataArr:(NSMutableArray *)dataArr {
    
    _dataArr = dataArr;
   
    [self.collectionView reloadData];
    NSInteger height = dataArr.count % 5;
    if (height == 0) {
        height = dataArr.count/5;
    }else {
        height = dataArr.count/5 + 1;
    }
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(height * 90 + 10);
        
    }];

}

- (void)setTopArr:(NSMutableArray *)topArr {
    
    _topArr = topArr;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.collectionView2 reloadData];
        
    });
    

}

//#pragma mark - UITableViewDataSource,UITableViewDelegate
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
//
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 1;
//
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
//    return cell;
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 10;
//}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    FoundDapp *data = self.dataArr[indexPath.item];
//    if ([self.delegate respondsToSelector:@selector(ETFoundHeaderViewDelegateCollectionClick:)]) {
//        [self.delegate ETFoundHeaderViewDelegateCollectionClick:data];
//    }
//}

@end
