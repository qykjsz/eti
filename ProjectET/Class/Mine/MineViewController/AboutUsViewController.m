//
//  AboutUsViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "AboutUsViewController.h"
#import "ETAboutUsModel.h"
#import "ETHTMLViewController.h"

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong)ETAboutUsModel *model;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.dataSource  = [NSMutableArray array];
    [self.view addSubview:self.detailTab];
    [self creatHeadView];
    [self getAlertsListData];
}

- (void)getAlertsListData{
     [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"api_giveus" parameters:@{@"":@""}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.model =[ETAboutUsModel mj_objectWithKeyValues:responseObject];
        [self.dataSource addObjectsFromArray:self.model.data];
        [self.detailTab reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
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
- (void)creatHeadView{
    UIView *headView = [ClassBaseTools viewWithBackgroundColor:[UIColor whiteColor]];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    self.detailTab.tableHeaderView =headView;
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = 5;
    iconImg.image = [UIImage imageNamed:@"AppIcon"];
    [headView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SCREEN_WIDTH/2-30);
        make.width.height.mas_offset(60);
        make.centerY.equalTo(headView).offset(-30);
    }];

    UILabel *appName = [ClassBaseTools labelWithFont:14 textColor:[UIColor blackColor] textAlignment:0];
    appName.text = @"EToken";
    [headView addSubview:appName];
    [appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconImg);
        make.top.equalTo(iconImg.mas_bottom).offset(15);
    }];
    UILabel *detail = [ClassBaseTools labelWithFont:14 textColor:[UIColor grayColor] textAlignment:0];
    detail.text = @"EToken是一款易用的数字资产钱包,作为专业数字资产钱包，安全放心、简单易用；支持ETH 多币种钱包转账、收款等管理与兑换，以及基于智能合约的币币兑换和丰富的 DApp，让区块链技术更好地融入你的生活。";
    detail.numberOfLines = 0;
    [headView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconImg);
        make.left.equalTo(headView.mas_left).offset(15);
         make.right.equalTo(headView.mas_right).offset(-15);
        make.top.equalTo(appName.mas_bottom).offset(15);
    }];
    
    [headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(detail.mas_bottom).offset(10);
    }];
}
#pragma mark--------DELEGATE-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
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
    ETAboutUsDataModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.name;
        cell.textLabel.font =[UIFont systemFontOfSize:14];
        //添加右侧注释
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ETHTMLViewController *vc = [[ETHTMLViewController alloc]init];
    ETAboutUsDataModel *model = self.dataSource[indexPath.row];
    vc.url = model.iosurl;
    [self.navigationController pushViewController:vc animated:true];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
@end
