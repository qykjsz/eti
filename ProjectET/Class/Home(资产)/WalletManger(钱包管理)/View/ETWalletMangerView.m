//
//  ETMyWalletView.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETWalletMangerView.h"
#import "ETMyWalletDetailCell.h"
#import "ETMyWalletIconCell.h"

#import "ETMyWalletLeftModel.h"

@interface ETWalletMangerView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftTab;

@property (nonatomic,strong) UITableView *rightTab;

@property (nonatomic,strong) NSMutableArray *coinModelArr;

@property (nonatomic,strong) NSMutableArray *coinNameArr;

@property (nonatomic,strong) UILabel *titleLb;

@property (nonatomic,strong) NSMutableArray *walletArr;


@end

@implementation ETWalletMangerView

- (void)reloadData {
    
    [self.walletArr removeAllObjects];
    [self.walletArr addObjectsFromArray:WALLET_ARR];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        NSArray *normalNameArr = @[@"qbgl_eos",@"qbgl_eth",@"qbgl_iost",@"qbgl_tron",@"qbgl_binance",@"qbgl_bos",@"qbgl_cosmos",@"qbgl_moac"];
        NSArray *seledctNameArr = @[@"qbgl_eos_xz",@"qbgl_eth_xz",@"qbgl_iost_xz",@"qbgl_tron_xz",@"qbgl_binance_xz",@"qbgl_bos_xz",@"qbgl_cosmos_xz",@"qbgl_moac_xz"];
        
        self.coinNameArr = [NSMutableArray arrayWithObjects:@"EOS",@"ETH",@"IOST",@"Tron",@"BINANCE",@"BOS",@"COSMOS",@"MOAC", nil];
        self.coinModelArr = [NSMutableArray array];
        self.walletArr = [NSMutableArray array];
        [self.walletArr addObjectsFromArray:WALLET_ARR];
        
        for (int i =0; i<8; i++) {
            
            ETMyWalletLeftModel *model = [ETMyWalletLeftModel new];
            if (i == 1) {
                model.isSelect = true;
            }else {
                model.isSelect = false;
            }
            model.normalName = normalNameArr[i];
            model.selectName = seledctNameArr[i];
            [self.coinModelArr addObject:model];
            
        }
        
       
        
        [self addSubview:self.leftTab];
        [self.leftTab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(60);
        }];
        
        [self addSubview:self.rightTab];
        [self.rightTab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.leftTab.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            
        }];
    
        
    }
    
    return self;
}

#pragma  mark - lazy load

- (UITableView *)leftTab {
    
    if (!_leftTab) {
        _leftTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTab.delegate = self;
        _leftTab.dataSource = self;
        _leftTab.backgroundColor = UIColorFromHEX(0xF2F2F2, 1);
        [_leftTab registerClass:[ETMyWalletIconCell class] forCellReuseIdentifier:@"ETMyWalletIconCell"];
        _leftTab.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _leftTab;
}

- (UITableView *)rightTab {
    
    if (!_rightTab) {
        _rightTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTab.delegate = self;
        _rightTab.dataSource = self;
        _rightTab.separatorStyle = UITableViewCellSelectionStyleNone;
        _rightTab.tableHeaderView = [self rightTabHeaderView];
        [_rightTab registerNib:[UINib nibWithNibName:@"ETMyWalletDetailCell" bundle:nil] forCellReuseIdentifier:@"ETMyWalletDetailCell"];
    }
    return _rightTab;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.leftTab) {
        return self.coinModelArr.count;
    }else {
        return self.walletArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTab) {
        ETMyWalletIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETMyWalletIconCell"];
        cell.model = self.coinModelArr[indexPath.row];
        return cell;
    }else {
        ETMyWalletDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETMyWalletDetailCell"];
        cell.model = self.walletArr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTab) {
        return 60;
    }else {
        return  140;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.leftTab) {
        
        for (ETMyWalletLeftModel *model in self.coinModelArr) {
            model.isSelect = NO;
        }
        
        ETMyWalletLeftModel *model = self.coinModelArr[indexPath.row];
        model.isSelect = YES;
        
        self.titleLb.text = self.coinNameArr[indexPath.row];
        [self.leftTab reloadData];
    }
    
    
}


- (UIView *)rightTabHeaderView {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.titleLb = [[UILabel alloc]init];
    self.titleLb.textColor = UIColorFromHEX(0x000000, 1);
    self.titleLb.font = [UIFont systemFontOfSize:14];
    self.titleLb.text = @"ETH";
    [backView addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(backView.mas_left).offset(15);
        make.top.bottom.equalTo(backView);
        
    }];
    
    UIButton *clickBtn = [[UIButton alloc]init];
    [clickBtn setImage:[UIImage imageNamed:@"qblb_tianjia"] forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.top.bottom.equalTo(backView);
        make.width.mas_equalTo(44);
        
    }];
    
    return backView;
}

#pragma mark - Action

- (void)addAction {
    
    if ([self.delegate respondsToSelector:@selector(ETWalletMangerViewDelegateAddWallet)]) {
        [self.delegate ETWalletMangerViewDelegateAddWallet];
    }

}


@end
