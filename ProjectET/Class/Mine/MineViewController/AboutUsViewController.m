//
//  AboutUsViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation AboutUsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.dataArray = @[@"使用协议",@"隐私条款",@"隐私日志",@"联系我们"];
    [self.view addSubview:self.detailTab];
    [self creatHeadView];
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
- (void)creatHeadView{
    UIView *headView = [ClassBaseTools viewWithBackgroundColor:[UIColor whiteColor]];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 175);
    self.detailTab.tableHeaderView =headView;
    UIView *iconImg = [ClassBaseTools viewWithBackgroundColor:[UIColor blueColor]];
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = 5;
    [headView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SCREEN_WIDTH/2-30);
        make.width.height.mas_offset(60);
        make.centerY.equalTo(headView).offset(-10);
    }];
    UILabel *appName = [ClassBaseTools labelWithFont:14 textColor:[UIColor blackColor] textAlignment:0];
    appName.text = @"APP";
    [headView addSubview:appName];
    [appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconImg);
        make.top.equalTo(iconImg.mas_bottom).offset(5);
    }];
    UILabel *detail = [ClassBaseTools labelWithFont:14 textColor:[UIColor grayColor] textAlignment:0];
    detail.text = @"关于此app简介";
    [headView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconImg);
        make.top.equalTo(appName.mas_bottom).offset(5);
    }];
}
#pragma mark--------DELEGATE-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
            make.width.mas_offset(SCREEN_WIDTH - 50);
            make.height.mas_offset(.5);
        }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _dataArray[indexPath.row];
        cell.textLabel.font =[UIFont systemFontOfSize:14];
        //添加右侧注释
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
@end
