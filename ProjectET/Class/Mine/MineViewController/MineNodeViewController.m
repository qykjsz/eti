//
//  MineNodeViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MineNodeViewController.h"
#import "MineNodeCell.h"
#import "ETNodeModel.h"

@interface MineNodeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong)ETNodeModel *model;
@end

@implementation MineNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"节点设置";
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.detailTab];
    [self creatNodeHeadView];
    UIView *bottomView = [ClassBaseTools viewWithBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:.1]];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(kTabBarHeight);
        make.bottom.equalTo(self.view);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    UILabel *addNode = [ClassBaseTools labelWithFont:15 textColor:UIColorFromHEX(0x1D57FF,1) textAlignment:1];
    addNode.text = @"添加自定义节点";
    [bottomView addSubview:addNode];
    [addNode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.height.equalTo(bottomView);
    }];
    
    [self getAlertsListData];
}

- (void)getAlertsListData{
     [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"get_jiedian" parameters:@{@"":@""}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.model =[ETNodeModel mj_objectWithKeyValues:responseObject];
        [self.dataArray addObjectsFromArray:self.model.data.data];
        [self.detailTab reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

- (void)creatNodeHeadView{
    UIView *headView = [ClassBaseTools viewWithBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:.1]];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
    self.detailTab.tableHeaderView = headView;
    UILabel *title = [ClassBaseTools labelWithFont:14 textColor:[UIColor blackColor] textAlignment:0];
    title.text = @"推荐节点";
    [headView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10);
    }];
    UILabel *speed = [ClassBaseTools labelWithFont:14 textColor:[UIColor lightGrayColor] textAlignment:0];
    speed.text = @"节点速度";
    [headView addSubview:speed];
    [speed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_right).offset(98);
        make.top.mas_offset(10);
    }];
    for (int i = 0;  i < 3 ; i++) {
        UIColor *color;
        NSString *title;
        switch (i) {
            case 0:
                color = UIColorFromHEX(0x00CAA1, 1);
                title = @"快";
                break;
            case 1:
                color = UIColorFromHEX(0xFFB61A, 1);
                title = @"中";
                break;
            case 2:
                color = UIColorFromHEX(0xE04159, 1);
                title = @"慢";
                break;
                
            default:
                break;
        }
        UILabel *point = [ClassBaseTools labelWithFont:30 textColor:color textAlignment:0];
        point.text = @"·";
        [headView addSubview:point];
        [point mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(speed.mas_right).offset(20 + ((30 + 5)*i));
            make.centerY.equalTo(headView.mas_centerY);
        }];
        UILabel *label = [ClassBaseTools labelWithFont:14 textColor:[UIColor lightGrayColor] textAlignment:0];
        label.text = title;
        [headView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(point.mas_right).offset(5);
            make.centerY.equalTo(speed);
        }];
    }
    
}
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight) style:UITableViewStylePlain];
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
    MineNodeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[MineNodeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
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
    ETNodeTwoDateModel *model = self.dataArray[indexPath.row];
    cell.nodeName.text = model.name;
    cell.nodeAddress.text = model.url;
    cell.speed.text = model.speed;
    if (indexPath.row == 0) {
        cell.nodeName.textColor = UIColorFromHEX(0x1D57FF, 1);
        [cell.selImg setHidden:false];
    }else {
        [cell.selImg setHidden:true];
    }
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
