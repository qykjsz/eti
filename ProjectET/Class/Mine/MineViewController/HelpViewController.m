//
//  HelpViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "HelpViewController.h"
#import "ETMineHelpModel.h"
#import "ETHTMLViewController.h"

@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray<NSNumber *> *isExpland;//是否展开
@property (nonatomic,strong)ETMineHelpModel *model;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    if (!self.dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    if (!self.isExpland) {
        self.isExpland = [NSMutableArray array];
    }
    [self.view addSubview:self.detailTab];
    
    
    [self getAlertsListData];
}

- (void)getAlertsListData{
    [HTTPTool requestDotNetWithURLString:@"api_givehelp" parameters:@{@"":@""}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.model =[ETMineHelpModel mj_objectWithKeyValues:responseObject];
        [self.dataSource addObjectsFromArray:self.model.data];
     
        //用0代表收起，非0（不一定是1）代表展开，默认都是展开的
        for (int i = 0; i < self.dataSource.count; i++) {
            if (i == 0) {
                [self.isExpland addObject:@1];
            }else {
                [self.isExpland addObject:@0];
            }
            
        }
        [self.detailTab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
//        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _detailTab;
}
#pragma mark--------DELEGATE-------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.isExpland[section] isEqual: @0]) {
        return 0;
    }else{
         return [self.dataSource[section] content].count;
    }
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    //单元格ID
    //重用单元格
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    UIView *line = [ClassBaseTools viewWithBackgroundColor:[UIColorFromHEX(0xE6E6E6, 1) colorWithAlphaComponent:1]];
    [cell.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(.5);
    }];
    cell.textLabel.frame = CGRectMake(25, 0, SCREEN_WIDTH - 25, 49);
    NSMutableArray *arr = [self.dataSource[indexPath.section] content];
    ETMineHelpContentModel *model = arr[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font =[UIFont systemFontOfSize:12];
    cell.textLabel.textColor = UIColorFromHEX(0x999999, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ETHTMLViewController *vc = [[ETHTMLViewController alloc]init];
    NSMutableArray *arr = [self.dataSource[indexPath.section] content];
    ETMineHelpContentModel *model = arr[indexPath.row];
    vc.url = model.url;
    [self.navigationController pushViewController:vc animated:true];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 49;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromHEX(0xE6E6E6, 1);
    [headerView addSubview:lineView];
    UILabel *title = [ClassBaseTools labelWithFont:14 textColor:UIColorFromHEX(0x333333, 1) textAlignment:0];
    title.frame = CGRectMake(10, 10, 200, 20);
    title.text = [self.dataSource[section] name];
    [headerView addSubview:title];
    
    //展开的小尖头V
    UIImageView  *arrowImageView = [[UIImageView alloc] init];
    [arrowImageView setContentMode:UIViewContentModeScaleAspectFit];
    UIImage *img = [UIImage imageNamed:@"help_jt"];
    [headerView addSubview:arrowImageView];
    
    //根据是否展开显示尖头的方向（向下或向上）
    if (![self.isExpland[section] boolValue]){
        //image的翻转
        img = [UIImage imageNamed:@"help_yjt"];
    }
    arrowImageView.image = img;
    
    UIButton *headerBtn = [[UIButton alloc] init];
    headerBtn.tag = 666+section;//添加标记
    [headerBtn addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-15);
        make.centerY.equalTo(headerView);
        make.width.mas_offset(14);
        make.height.mas_offset(14);
    }];
//    arrowImageView.sd_layout
//    .rightEqualToView(headerView).offset(-15)
//    .centerYEqualToView(headerView)
//    .widthIs(15)
//    .heightIs(9);
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView);
        make.top.equalTo(headerView);
        make.width.equalTo(headerView);
        make.height.equalTo(headerView);
    }];
//    headerBtn.sd_layout
//    .leftEqualToView(headerView)
//    .topSpaceToView(headerView,0)
//    .widthRatioToView(headerView,1)
//    .heightRatioToView(headerView,1);
    
    return headerView;
}
- (void)headerButtonAction:(UIButton *)button
{
      NSInteger section = button.tag - 666;
    self.isExpland[section] = [self.isExpland[section] isEqual:@0]?@1:@0;
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    [self.detailTab reloadSections:set withRowAnimation:UITableViewRowAnimationFade];//刷新某个section
    
}
@end
