//
//  HelpViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray<NSNumber *> *isExpland;//是否展开
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    if (!self.dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    if (!self.isExpland) {
        self.isExpland = [NSMutableArray array];
    }
    
    NSArray *titleArray1 = @[@"服务人次",@"充值业绩",@"铺垫目标",@"消费业绩"];
    NSArray *titleArray2 = @[@"调理备忘",@"回访顾客",@"预约提醒"];
    //用一个二维数组来模拟数据。
    self.dataArray = [NSArray arrayWithObjects:titleArray1,titleArray2,nil].mutableCopy;
    
    //用0代表收起，非0（不一定是1）代表展开，默认都是展开的
    for (int i = 0; i < self.dataArray.count; i++) {
        [self.isExpland addObject:@1];
    }
    [self.view addSubview:self.detailTab];
}
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _detailTab;
}
#pragma mark--------DELEGATE-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    if ([self.isExpland[section] boolValue]) {
        return array.count;
    }
    else {
        return 0;
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
    UIView *line = [ClassBaseTools viewWithBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.3]];
    [cell.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(.5);
    }];
    
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerView.backgroundColor = [UIColor grayColor];
    
    UILabel *title = [ClassBaseTools labelWithFont:15 textColor:[UIColor blackColor] textAlignment:0];
    title.frame = CGRectMake(20, 10, 200, 20);
    title.text = @"常见问题";
    [headerView addSubview:title];
    
    //展开的小尖头V
    UIImageView  *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.tag = 600+section;
    UIImage *img = [UIImage imageNamed:@"wo_yjt"];
    [headerView addSubview:arrowImageView];
    
    //根据是否展开显示尖头的方向（向下或向上）
    if (![self.isExpland[section] boolValue]){
        //image的翻转
        img = [UIImage imageWithCGImage:img.CGImage scale:1 orientation:UIImageOrientationDown];
    }
    arrowImageView.image = img;
    
    UIButton *headerBtn = [[UIButton alloc] init];
    headerBtn.tag = 666+section;//添加标记
    [headerBtn addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-15);
        make.centerY.equalTo(headerView);
        make.width.mas_offset(7);
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
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:600+button.tag - 666];
    //尖头翻转180度
    imageView.transform = CGAffineTransformMakeRotation(M_PI);
    
    NSInteger section = button.tag - 666;
    self.isExpland[section] = [self.isExpland[section] isEqual:@0]?@1:@0;
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    [self.detailTab reloadSections:set withRowAnimation:UITableViewRowAnimationFade];//刷新某个section
    
}
@end
