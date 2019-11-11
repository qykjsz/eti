//
//  ETTransferDetailViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransferDetailViewController.h"
#import "ETTransferDetailCell.h"
#import "ETTransferDetailModel.h"

@interface ETTransferDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ETTransferDetailCellDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) ETTransferDetailModel *model;

@property (nonatomic,strong) UILabel *timeLb;

@property (nonatomic,strong) UILabel *statusLb;

@property (nonatomic,strong) UIImageView *iconImage;

@end

@implementation ETTransferDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self detailRequest];
    
}

#pragma mark - NET
- (void)detailRequest {
    
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:model.address forKey:@"address"];
    [dict setValue:self.glod forKey:@"glod"];
    [dict setValue:self.Id forKey:@"id"];

    [HTTPTool requestDotNetWithURLString:@"et_recordorderone" parameters:dict type:kPOST success:^(id responseObject) {
        
        self.model = [ETTransferDetailModel mj_objectWithKeyValues:responseObject];
        //     1.成功 0.失败
        if ([self.model.data.status integerValue] == 1) {
            self.statusLb.text = @"转账成功";
            self.iconImage.image = [UIImage imageNamed:@"xq_cg"];
        }else {
            self.iconImage.image = [UIImage imageNamed:@"xq_shibai"];
            self.statusLb.text = @"转账失败";
        }
        self.timeLb.text = self.model.data.time;
        [self.detailTab reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    
    UIScrollView *backScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [backScro setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 50)];
    [self.view addSubview:backScro];
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bigBack"]];
    backImage.userInteractionEnabled = YES;
    backImage.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 520);
    [backScro addSubview:backImage];
   
    
   
    [backImage addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(backImage).offset(10);
        make.bottom.right.equalTo(backImage).offset(-10);
        
    }];
    
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETTransferDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETTransferDetailCell"];
    cell.rowPath = indexPath;
    cell.delegate = self;
    switch (indexPath.row) {
        case 0: {
            cell.titleLb.text = @"金额:";
            cell.detailLb.text = [NSString stringWithFormat:@"%@%@",self.model.data.name,self.model.data.amount];;
            cell.clickBtn.hidden = YES;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = YES;
        }
            break;
        case 1: {
            cell.titleLb.text = @"矿工费用:";
            cell.detailLb.text = self.model.data.cost;
            cell.clickBtn.hidden = YES;
            cell.subDetailLb.text = [NSString stringWithFormat:@"=Gas(%@)*GasPrice(%@ gwei)",self.model.data.gas,self.model.data.gasp];
            cell.lineImage.hidden = YES;
        }
            break;
        case 2: {
            cell.titleLb.text = @"收款地址:";
            cell.detailLb.text = self.model.data.otheraddress;
            cell.clickBtn.hidden = NO;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = YES;
        }
            break;
        case 3: {
            cell.titleLb.text = @"付款地址:";
            cell.detailLb.text = self.model.data.address;
            cell.clickBtn.hidden = NO;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = YES;
        }
            break;
        case 4: {
            cell.titleLb.text = @"备注：";
            cell.detailLb.text = @"暂无";
            cell.clickBtn.hidden = YES;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = NO;
        }
            break;
        case 5: {
            cell.titleLb.text = @"交易号:";
            cell.detailLb.text = self.model.data.hashString;
            cell.clickBtn.hidden = NO;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = YES;
        }
            break;
        case 6: {
            cell.titleLb.text = @"区块:";
            cell.detailLb.text = self.model.data.blocknumber;
            cell.clickBtn.hidden = YES;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = YES;
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - ETTransferDetailCellDelegate
- (void)ETTransferDetailCellDelegateWithRowPath:(NSIndexPath *)rowPath {
    
    if (rowPath.row == 2) {
         [Tools copyClickWithText:self.model.data.otheraddress];
    }else if (rowPath.row == 3) {
         [Tools copyClickWithText:self.model.data.address];
    }else {
         [Tools copyClickWithText:self.model.data.hashString];
    }
   
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETTransferDetailCell class] forCellReuseIdentifier:@"ETTransferDetailCell"];
        _detailTab.tableHeaderView = [self headerView];
    }
    return _detailTab;
}


- (UIView *)headerView {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    self.iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xq_cg"]];
    [headerView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(headerView.mas_centerX);
        make.top.equalTo(headerView.mas_top).offset(25);
        make.width.height.mas_equalTo(44);
        
    }];
    
    self.statusLb = [[UILabel alloc]init];
    self.statusLb.text = @"转账成功";
    self.statusLb.textColor = UIColorFromHEX(0x000000, 1);
    self.statusLb.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:self.statusLb];
    [self.statusLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(headerView.mas_centerX);
        make.top.equalTo(self.iconImage.mas_bottom).offset(15);
        
    }];
    
    self.timeLb = [[UILabel alloc]init];
    self.timeLb.text = self.model.data.time;
    self.timeLb.textColor = UIColorFromHEX(0x999999, 1);
    self.timeLb.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:self.timeLb];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(headerView.mas_centerX);
        make.top.equalTo(self.statusLb.mas_bottom).offset(15);
        
    }];
    
    return headerView;
}



@end
