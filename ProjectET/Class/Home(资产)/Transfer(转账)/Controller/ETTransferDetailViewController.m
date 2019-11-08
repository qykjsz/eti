//
//  ETTransferDetailViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/7.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTransferDetailViewController.h"
#import "ETTransferDetailCell.h"

@interface ETTransferDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ETTransferDetailCellDelegate>

@property (nonatomic,strong) UITableView *detailTab;
@end

@implementation ETTransferDetailViewController

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
            cell.detailLb.text = @"100 ETH";
            cell.clickBtn.hidden = YES;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = YES;
        }
            break;
        case 1: {
            cell.titleLb.text = @"矿工费用:";
            cell.detailLb.text = @"0.0003267005 ether";
            cell.clickBtn.hidden = YES;
            cell.subDetailLb.text = @"=Gas(53,401)*GasPrice(5.00 gwei)";
            cell.lineImage.hidden = YES;
        }
            break;
        case 2: {
            cell.titleLb.text = @"收款地址:";
            cell.detailLb.text = @"0xfoo22VCF987362Tghey356yfsr  wu193uYhNB5200";
            cell.clickBtn.hidden = NO;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = YES;
        }
            break;
        case 3: {
            cell.titleLb.text = @"付款地址:";
            cell.detailLb.text = @"0xfoo22VCF987362Tghey356yfsr  wu193uYhNB5200";
            cell.clickBtn.hidden = NO;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = YES;
        }
            break;
        case 4: {
            cell.titleLb.text = @"备注：";
            cell.detailLb.text = @"";
            cell.clickBtn.hidden = YES;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = NO;
        }
            break;
        case 5: {
            cell.titleLb.text = @"交易号:";
            cell.detailLb.text = @"0xfoo2...NB5200";
            cell.clickBtn.hidden = NO;
            cell.subDetailLb.text = @"";
            cell.lineImage.hidden = YES;
        }
            break;
        case 6: {
            cell.titleLb.text = @"区块:";
            cell.detailLb.text = @"08340895";
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
    
    [Tools copyClickWithText:@"宝宝"];

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
    
    UIImageView *iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xq_cg"]];
    [headerView addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(headerView.mas_centerX);
        make.top.equalTo(headerView.mas_top).offset(25);
        make.width.height.mas_equalTo(44);
        
    }];
    
    UILabel *statusLb = [[UILabel alloc]init];
    statusLb.text = @"转账成功";
    statusLb.textColor = UIColorFromHEX(0x000000, 1);
    statusLb.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:statusLb];
    [statusLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(headerView.mas_centerX);
        make.top.equalTo(iconImage.mas_bottom).offset(15);
        
    }];
    
    UILabel *timeLb = [[UILabel alloc]init];
    timeLb.text = @"2019/11/05 12:45";
    timeLb.textColor = UIColorFromHEX(0x999999, 1);
    timeLb.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:timeLb];
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(headerView.mas_centerX);
        make.top.equalTo(statusLb.mas_bottom).offset(15);
        
    }];
    
    return headerView;
}



@end
