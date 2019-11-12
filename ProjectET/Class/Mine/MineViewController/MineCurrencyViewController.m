//
//  MineCurrencyViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MineCurrencyViewController.h"

@interface MineCurrencyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation MineCurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"货币单位";
    self.dataArray = @[@"AUD",@"CNY",@"EOS",@"EUR",@"GBP",@"MRY",@"USD"];
    [self.view addSubview:self.detailTab];
    [self creatCurrencyFootView];
}
- (void)creatCurrencyFootView{
    UIView *footView = [ClassBaseTools viewWithBackgroundColor:[UIColor whiteColor]];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    self.detailTab.tableFooterView = footView;
    UIButton *conBtn = [ClassBaseTools buttonWithFont:15 titlesColor:[UIColor whiteColor] contentHorizontalAlignment:0 title:@"确定"];
    [conBtn setBackgroundColor:[UIColor blueColor]];
    conBtn.layer.masksToBounds = YES;
    conBtn.layer.cornerRadius = 5;
    [footView addSubview:conBtn];
    [conBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.width.mas_offset(SCREEN_WIDTH-30);
        make.height.mas_offset(44);
        make.bottom.equalTo(footView.mas_bottom).offset(30);
    }];
}
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 26;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _detailTab;
}
#pragma mark--------DELEGATE-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
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
    
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
@end
