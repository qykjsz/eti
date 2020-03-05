//
//  ETNewChatGroupUserViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatGroupUserViewController.h"
#import "ETNewChatGroupDetailsModel.h"
#import "ETNewChatGroupDetailsCell.h"
#import "ETNewChatCreateGroupViewController.h"

@interface ETNewChatGroupUserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *conllectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic,strong)ETNewChatGroupDetailsModel *model;

@end

@implementation ETNewChatGroupUserViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        [self getChatGroupusers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群成员";
    self.dataSource = [NSMutableArray array];
       [self.conllectionView registerNib:[UINib nibWithNibName:@"ETNewChatGroupDetailsCell" bundle:nil] forCellWithReuseIdentifier:@"ETNewChatGroupDetailsCell"];
       [self layoutCollectionView];

    // Do any additional setup after loading the view from its nib.
}

- (void)layoutCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 20);
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 120)/5, 80);
    [self.conllectionView setCollectionViewLayout:layout];
}



///好友列表
- (void)getChatGroupusers{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_groupsuser" parameters:@{@"qid":self.tid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        [self.dataSource removeAllObjects];
        if (baseModel.code == 200) {
            self.model =[ETNewChatGroupDetailsModel mj_objectWithKeyValues:responseObject];
            [self.dataSource addObjectsFromArray:self.model.data];
             self.title = [NSString stringWithFormat:@"群聊信息(%ld)",self.dataSource.count];
            ETNewChatGroupDetailsDataModel *model1 = [ETNewChatGroupDetailsDataModel new];
                                      model1.photo = @"lt_tjyqhy";
                                      model1.name = @"";
                                      [self.dataSource addObject:model1];
            if ([model.ryID isEqualToString:self.qzid]) {
                ETNewChatGroupDetailsDataModel *model2 = [ETNewChatGroupDetailsDataModel new];
                           model2.photo = @"lt_scqy";
                           model2.name = @"";
                           [self.dataSource addObject:model2];
             }
            
            
            [self.conllectionView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.dataSource removeAllObjects];
        //        [self.tableView reloadData];
    }];
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ETNewChatGroupDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ETNewChatGroupDetailsCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ETNewChatGroupDetailsDataModel *model = self.dataSource[indexPath.row];
    ///加群员
    if ([model.photo isEqualToString: @"lt_tjyqhy"]) {
        ETNewChatCreateGroupViewController *vc = [ETNewChatCreateGroupViewController new];
        vc.type = 1;
        vc.tid = self.tid;
        [self.navigationController pushViewController:vc animated:true];
        
    ///移除群员
    }else if ([model.photo isEqualToString: @"lt_scqy"]) {
        ETNewChatCreateGroupViewController *vc = [ETNewChatCreateGroupViewController new];
        vc.type = 2;
        vc.tid = self.tid;
        [self.navigationController pushViewController:vc animated:true];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
