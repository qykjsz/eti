//
//  ETSecretImportController.m
//  ProjectET
//
//  Created by hufeng on 2019/10/31.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETColdWalletViewController.h"


// cell
#import "ETCreatYYViewCell.h"
#import "ETCreatWalletInputCell.h"
#import "ETCreatWalletInfoCell.h"

// view
#import "ETSecertCreatView.h"

@interface ETColdWalletViewController ()<UITableViewDelegate,UITableViewDataSource,ETCreatYYViewCellDelegate,ETSecertCreatViewDelegate>

@property (nonatomic,strong) UITableView *detailTab;

@end

@implementation ETColdWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [right setImage:[UIImage imageNamed:@"zjc_sao"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    self.title = @"冷钱包";
    [self.view addSubview:self.detailTab];
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 120;
    }else {
        return 49;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ETCreatYYViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatYYViewCell"];
        cell.delegate = self;
        cell.clickBtn.hidden = NO;
        cell.textView.placeholderText = @"请输入明文私钥";
        return  cell;
    }else if (indexPath.row == 1) {
        ETCreatWalletInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatWalletInfoCell"];
        cell.titleLb.text = @"钱包体系";
        cell.subTitle.text = @"以太坊底层";
        return cell;
    }else {
        ETCreatWalletInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETCreatWalletInputCell"];
        
        switch (indexPath.row) {
            case 2:{
                cell.titleLb.text = @"钱包名字:";
                cell.hideBtn.hidden = YES;
                cell.textfiled.placeholder = @"请输入您的钱包名称";
            }
                break;
            case 3:{
                cell.titleLb.text = @"设置密码:";
                cell.hideBtn.hidden = false;
                cell.textfiled.placeholder = @"请输入您的钱包密码";
            }
                break;
            case 4:{
                cell.titleLb.text = @"确认密码:";
                cell.hideBtn.hidden = true;
                cell.textfiled.placeholder = @"请再次输入您的钱包密码";
            }
                break;
            default:
                break;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - ETCreatYYViewCellDelegate
- (void)ETCreatYYViewCellDelegateSecertClick {
    
    ETSecertCreatView *view = [[ETSecertCreatView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.delegate = self;
    view.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 1;
    }];
   
    
}

#pragma mark - ETSecertCreatViewDelegate
- (void)ETSecertCreatViewDelegateGyaoClick:(NSString *)Gyao andSyao:(NSString *)Syao {
    
    NSLog(@"%@ %@",Gyao,Syao);
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerClass:[ETCreatYYViewCell class] forCellReuseIdentifier:@"ETCreatYYViewCell"];
        [_detailTab registerNib:[UINib nibWithNibName:@"ETCreatWalletInputCell" bundle:nil] forCellReuseIdentifier:@"ETCreatWalletInputCell"];
        [_detailTab registerNib:[UINib nibWithNibName:@"ETCreatWalletInfoCell" bundle:nil] forCellReuseIdentifier:@"ETCreatWalletInfoCell"];
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.tableFooterView = [self footerView];
    }
    return _detailTab;
}

- (UIView *)footerView{
    
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 44)];
    btn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    [btn setTitle:@"开始导入" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    
    UIButton *selectBtn = [[UIButton alloc]init];
    [selectBtn setImage:[UIImage imageNamed:@"qb_weix"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"qb_xuan"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(backView.mas_top);
        make.width.height.mas_equalTo(30);
        
    }];
    
    UILabel *tipsLb = [[UILabel alloc]init];
    tipsLb.text = @"我已仔细阅读并同意";
    tipsLb.textColor = UIColorFromHEX(0x999999, 1);
    tipsLb.font = [UIFont systemFontOfSize:12];
    [backView addSubview:tipsLb];
    [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(selectBtn.mas_centerY);
        make.left.equalTo(selectBtn.mas_right);
        
    }];
    
    UIButton *clickBtn = [[UIButton alloc]init];
    [clickBtn setTitle:@"服务及隐私条款" forState:UIControlStateNormal];
    [clickBtn setTitleColor:UIColorFromHEX(0x1D57FF, 1) forState:UIControlStateNormal];
    clickBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [backView addSubview:clickBtn];
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(selectBtn.mas_centerY);
        make.left.equalTo(tipsLb.mas_right).offset(5);
        
    }];
    
    UIButton *bottomBtn = [[UIButton alloc]init];
    [bottomBtn setTitle:@"什么是私钥?" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomBtn setTitleColor:UIColorFromHEX(0x1D57FF, 1) forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(questionClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(btn.mas_bottom).offset(0);
        make.centerX.equalTo(backView.mas_centerX);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
        
    }];
    
    return backView;
    
}


#pragma mark - Action

- (void)clickAction {
    
}

- (void)rightAction {
    
}

- (void)selectAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
}
@end
