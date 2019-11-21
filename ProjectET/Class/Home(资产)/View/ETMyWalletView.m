//
//  ETMyWalletView.m
//  ProjectET
//
//  Created by hufeng on 2019/10/30.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETMyWalletView.h"
#import "ETMyWalletDetailCell.h"
#import "ETMyWalletIconCell.h"

#import "ETMyWalletLeftModel.h"

@interface ETMyWalletView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *leftTab;

@property (nonatomic,strong) UITableView *rightTab;

@property (nonatomic,strong) UIView *holeView;

@property (nonatomic,strong) NSMutableArray *coinModelArr;

@property (nonatomic,strong) NSMutableArray *coinNameArr;

@property (nonatomic,strong) UILabel *titleLb;

@property (nonatomic,strong) NSMutableArray *walletArr;

@property (nonatomic,assign) NSInteger selectPage;

@property (nonatomic,strong) UIButton *clickBtn;


@end

@implementation ETMyWalletView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.selectPage = 1;
        NSArray *normalNameArr = @[@"qbgl_eos",@"qbgl_eth",@"qbgl_iost",@"qbgl_tron",@"qbgl_binance",@"qbgl_bos",@"qbgl_cosmos",@"qbgl_moac"];
        NSArray *seledctNameArr = @[@"qbgl_eos_xz",@"qbgl_eth_xz",@"qbgl_iost_xz",@"qbgl_tron_xz",@"qbgl_binance_xz",@"qbgl_bos_xz",@"qbgl_cosmos_xz",@"qbgl_moac_xz"];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
//        [self addGestureRecognizer:tap];
        
        self.coinNameArr = [NSMutableArray arrayWithObjects:@"EOS",@"ETH",@"IOST",@"Tron",@"BINANCE",@"BOS",@"COSMOS",@"MOAC", nil];
        self.coinModelArr = [NSMutableArray array];
        self.walletArr = [NSMutableArray array];
        [self.walletArr addObjectsFromArray:WALLET_ARR];
        
        for (int i = 0; i<self.walletArr.count; i++) {
            
            ETWalletModel *model = self.walletArr[i];
            if (model.isCurrentWallet) {
                [self.walletArr insertObject:model atIndex:0];
                [self.walletArr removeObjectAtIndex:i+1];
                break;
            }
        }
        
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
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        self.holeView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 420)];
        self.holeView.backgroundColor = [UIColor whiteColor];
        UIView *topView = [self topView];
        [self.holeView addSubview:topView];
        
        [self.holeView addSubview:self.leftTab];
        [self.leftTab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.holeView.mas_left);
            make.top.equalTo(topView.mas_bottom);
            make.bottom.equalTo(self.holeView.mas_bottom);
            make.width.mas_equalTo(60);
        }];
        
        [self.holeView addSubview:self.rightTab];
        [self.rightTab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.leftTab.mas_right);
            make.top.equalTo(topView.mas_bottom);
            make.bottom.equalTo(self.holeView.mas_bottom);
            make.right.equalTo(self.holeView.mas_right);
            
        }];
        
        [self addSubview:self.holeView];
        
    }
    
    return self;
}

#pragma  mark - lazy load

- (UITableView *)leftTab {
    
    if (!_leftTab) {
        _leftTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTab.delegate = self;
        _leftTab.dataSource = self;
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
        if (self.selectPage != 1) {
            return 0;
        }
        return self.walletArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTab) {
        ETMyWalletIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETMyWalletIconCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.coinModelArr[indexPath.row];
        return cell;
    }else {
        ETMyWalletDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETMyWalletDetailCell"];
        cell.model = self.walletArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

    
    if (tableView == self.leftTab) {
        
        self.selectPage = indexPath.row;
        [self.rightTab reloadData];
        
        for (ETMyWalletLeftModel *model in self.coinModelArr) {
            model.isSelect = NO;
        }
        
        ETMyWalletLeftModel *model = self.coinModelArr[indexPath.row];
        model.isSelect = YES;
        
        self.titleLb.text = self.coinNameArr[indexPath.row];
        if (indexPath.row != 1) {
            self.clickBtn.hidden = YES;
        }else {
            self.clickBtn.hidden = NO;
        }
        [self.leftTab reloadData];
    }else {
        
        [self cancelAction:^{
            if ([self.delegate respondsToSelector:@selector(ETMyWalletViewDelegateDidSelect:)]) {
                [self.delegate ETMyWalletViewDelegateDidSelect:indexPath];
            }
        }];
        
    }
    
   
}


// 就是顶部那个
#pragma mark - topView
- (UIView *)topView {
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    topView.backgroundColor = UIColor.whiteColor;
    
    UIButton *clickBtn = [[UIButton alloc] init];
    [clickBtn setImage:[UIImage imageNamed:@"qblb_shezhi"] forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(mangerClickAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.equalTo(topView);
        make.width.mas_equalTo(49);
        
    }];
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"钱包列表";
    titleLb.textColor = UIColorFromHEX(0x000000, 1);
    [topView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(topView.mas_centerX);
        make.top.bottom.equalTo(topView);
        
    }];
    
    UIButton *cancleBtn = [[UIButton alloc]init];
    [cancleBtn setImage:[UIImage imageNamed:@"qblb_guanbi"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.top.bottom.equalTo(topView);
        make.width.mas_equalTo(49);
        
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromHEX(0xEBEBEB, 1);
    [topView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(topView);
        make.height.mas_equalTo(1);
    }];
    
    return topView;
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
    
    self.clickBtn = [[UIButton alloc]init];
    [self.clickBtn setImage:[UIImage imageNamed:@"qblb_tianjia"] forState:UIControlStateNormal];
    [self.clickBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.clickBtn];
    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.top.bottom.equalTo(backView);
        make.width.mas_equalTo(44);
        
    }];
    
    return backView;
}

#pragma mark - Action
// 管理按钮
- (void)mangerClickAction {
    
    WEAK_SELF(self);
    [self cancelAction:^{
        STRONG_SELF(self);
        if ([self.delegate respondsToSelector:@selector(ETMyWalletViewDelegateWalletManger)]) {
            [self.delegate ETMyWalletViewDelegateWalletManger];
        }
    }];
   
}

//添加钱包
- (void)addAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.holeView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 420);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
            if ([self.delegate respondsToSelector:@selector(ETMyWalletViewDelegateAddWallet)]) {
                [self.delegate ETMyWalletViewDelegateAddWallet];
            }
            
        }];
        
    }];
    
    
}

// 消失按钮
- (void)cancelAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.holeView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 420);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
            
        }];
        
    }];
    

}

- (void)cancelAction:(void (^)(void))complicate {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.holeView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 420);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
            complicate();
        }];
        
    }];
    
    
}

- (void)dismissAction {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.holeView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 420);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
    
        }];
        
    }];
    
}

- (void)show {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.holeView.frame = CGRectMake(0, SCREEN_HEIGHT - 420, SCREEN_WIDTH, 420);
        
    }];
}
@end
