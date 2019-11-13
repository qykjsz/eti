//
//  MarketViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MarketViewController.h"
#import "MarketCell.h"
#import "ETMarkModel.h"

@interface MarketViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) ETMarkModel *model;

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"行情";
    [self getMarkListData];
    UIView *topView = [ClassBaseTools viewWithBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wo_top_bg"]]];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(168);
        make.top.mas_offset(0);
    }];
    [self creatHeadView];
    [self.view addSubview:self.detailTab];
}
- (void)getMarkListData{
    [HTTPTool requestDotNetWithURLString:@"et_quotation" parameters:@{} type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.model = [ETMarkModel mj_objectWithKeyValues:responseObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.detailTab reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}
- (void)creatHeadView{
    UIView *view = [ClassBaseTools viewWithBackgroundColor:[UIColor whiteColor]];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [self.detailTab setTableHeaderView:view];
    UILabel *title = [ClassBaseTools labelWithFont:14 textColor:[UIColor grayColor] textAlignment:0];
    title.text = @"Thursday，10月 2019";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(25);
        make.centerY.equalTo(view);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-118-kTabBarHeight) style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 26;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTab.backgroundColor = [UIColor whiteColor];
    }
    return _detailTab;
}
-(void)ConsultHeadViewDelegateWithClikTag:(NSInteger)tag{
    NSLog(@"%ld",(long)tag);
}
#pragma mark--------DELEGATE-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.model.data.count>0) {
        return self.model.data.count;
    }else{
        return 0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    //单元格ID
    //重用单元格
    MarketCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[MarketCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    UIView *line = [ClassBaseTools viewWithBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.3]];
    [cell.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(.5);
    }];
    markData *markModel = self.model.data[indexPath.row];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:markModel.img] placeholderImage:[UIImage imageNamed:@"zc_eth"]];
    cell.name.text = markModel.name;
    cell.number.text = markModel.shangmoney;
    cell.money.text = markModel.xiamoney;
    cell.gains.text = markModel.zd;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
@end
