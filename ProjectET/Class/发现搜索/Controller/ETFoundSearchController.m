//
//  ETFoundSearchController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/16.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundSearchController.h"
#import "ETHTMLViewController.h"

// view
#import "ETFoundSectionView.h"
#import "ETFoundSerarchNavView.h"
#import "ETFoundSearchCollectionView.h"
#import "ETFoundSearchDetailCell.h"

//model
#import "ETFoundHotModel.h"
#import "ETFoundDetailModel.h"

@interface ETFoundSearchController ()<ETFoundSerarchNavViewDelegate,ETFoundSearchCollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) ETFoundSectionView *sectionView;

@property (nonatomic,strong) ETFoundSearchCollectionView *headerView;

@property (nonatomic,strong) ETFoundSerarchNavView *navView;

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,strong) NSMutableArray *hotData;

@property (nonatomic,strong) NSMutableArray *detailData;

@end

@implementation ETFoundSearchController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hotData = [NSMutableArray array];
    self.detailData = [NSMutableArray array];
    self.view.backgroundColor = UIColorFromHEX(0xf5f5f5, 1);
    // 设置顶部搜索
    self.navView = [[ETFoundSerarchNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kStatusAndNavHeight)];
    self.navView.delegate = self;
    [self.view addSubview:self.navView];
    
    self.sectionView = [[NSBundle mainBundle] loadNibNamed:@"ETFoundSectionView" owner:nil options:nil].lastObject;
    self.sectionView.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), SCREEN_WIDTH, 98);
    WEAK_SELF(self);
    [self.sectionView setFoundWebViewblock:^(NSString * _Nonnull str) {
        
        STRONG_SELF(self);
        ETHTMLViewController *vc = [[ETHTMLViewController alloc]init];
        vc.url = str;
        [self.navigationController pushViewController:vc animated:true];
        
    }];
    [self.view addSubview:self.sectionView];
    

    
    self.headerView = [[ETFoundSearchCollectionView alloc]init];
    self.headerView.delegate = self;
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.detailTab];
    self.detailTab.tableHeaderView = self.headerView;
    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        STRONG_SELF(self);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.sectionView.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    [self hotRequest];
    
}

#pragma mark -热门接口
- (void)hotRequest {
    
    [HTTPTool requestDotNetWithURLString:@"et_apphot" parameters:nil type:kPOST success:^(id responseObject) {
        
        ETFoundHotModel *model = [ETFoundHotModel mj_objectWithKeyValues:responseObject];
        for (FoundHotData *data in model.data) {
            [self.hotData addObject:data.name];
        }
        self.headerView.dataArr = self.hotData;
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -搜索接口
- (void)searchRequest:(NSString *)text {
    
    [HTTPTool requestDotNetWithURLString:@"et_selapp" parameters:@{@"appname":text} type:kPOST success:^(id responseObject) {
        
        ETFoundDetailModel *model = [ETFoundDetailModel mj_objectWithKeyValues:responseObject];
        
        [self.detailData removeLastObject];
        [self.detailData addObjectsFromArray:model.data];
      
        if (self.detailData.count == 0) {
            self.detailTab.tableHeaderView = self.headerView;
        }else {
            self.detailTab.tableHeaderView = nil;
        }
          [self.detailTab reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.detailData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETFoundSearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETFoundSearchDetailCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.model = self.detailData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 73;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETFoundDetailData *data = self.detailData[indexPath.row];
    ETHTMLViewController *vc = [[ETHTMLViewController alloc]init];
    vc.url = data.url;
    vc.title = data.name;
    [self.navigationController pushViewController:vc animated:true];
    
}
#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETFoundSearchDetailCell" bundle:nil] forCellReuseIdentifier:@"ETFoundSearchDetailCell"];
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _detailTab;
}


#pragma mark - ETFoundSerarchNavViewDelegate
- (void)ETFoundSerarchNavViewCancle {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)ETFoundSerarchNavViewTextfiled:(UITextField *)textfield {
    
    self.sectionView.topLb.text = textfield.text;
    self.sectionView.bottomLb.text = [NSString stringWithFormat:@"http://%@",textfield.text];
    
    if ([Tools checkStringIsEmpty:textfield.text]) {
        [self.detailData removeAllObjects];
        self.detailTab.tableHeaderView = self.headerView;
        [self.detailTab reloadData];
    }else {
        self.detailTab.tableHeaderView = nil;
    }
    
   
    
}

- (void)ETFoundSerarchNavViewReturn:(UITextField *)textfiled {
    
    [self searchRequest:textfiled.text];
    
    
    [self.view endEditing:YES];
}

#pragma mark - ETFoundSearchCollectionViewDelegate
- (void)ETFoundSearchCollectionViewDelegateClick:(NSString *)str {
    
    self.navView.textfiled.text = str;
    
    self.sectionView.topLb.text = str;
    self.sectionView.bottomLb.text = [NSString stringWithFormat:@"http://%@",str];
    
    [self searchRequest:str];
    self.detailTab.tableHeaderView = nil;
    
}

@end
