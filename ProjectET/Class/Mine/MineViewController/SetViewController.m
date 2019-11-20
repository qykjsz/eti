//
//  SetViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "SetViewController.h"
#import "MineNodeViewController.h"
#import "LanguageViewController.h"
#import "MineCurrencyViewController.h"
#import "MinePushViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统设置";
    self.dataArray = @[@"语言选择",@"节点设置",@"货币单位",@"推送通知",@"红涨绿跌"];
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
    //添加右侧注释
    
    if (indexPath.row == 4) {
        UISwitch *btn = [[UISwitch alloc]init];
        btn.on = YES;
        btn.transform = CGAffineTransformMakeScale(0.75, 0.75);
        [cell.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.top.mas_offset(10);
            make.width.mas_offset(38.5);
            make.height.mas_offset(22.5);
        }];
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            LanguageViewController *ctrl = [[LanguageViewController alloc]init];
            [ctrl setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 1:{
            MineNodeViewController *ctrl = [[MineNodeViewController alloc]init];
            [ctrl setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 2:{
            MineCurrencyViewController *ctrl = [[MineCurrencyViewController alloc]init];
            [ctrl setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 3:{
            MinePushViewController *ctrl = [[MinePushViewController alloc]init];
            [ctrl setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
