//
//  AlertsViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/11.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "AlertsViewController.h"
#import "AlertsCell.h"
#import "QuickViewCell.h"
#import "AlertsModel.h"
#import "ETConAlertsModel.h"
#import "QuickViewController.h"

@interface AlertsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSMutableArray *dataArray;
//@property (nonatomic,strong)AlertsModel *model;
@property (nonatomic,strong)ETConAlertsModel *model;

@end

@implementation AlertsViewController{
    int currentPage;
}
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
    self.title = @"快讯";
    currentPage = 0;
    self.dataArray = [NSMutableArray array];
    [self getAlertsListData];
    UIView *topView = [ClassBaseTools viewWithBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wo_top_bg"]]];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(168);
        make.top.mas_offset(0);
    }];
    
    [self.view addSubview:self.detailTab];
    [self creatHeadView];
    __weak typeof(self)  weakSelf = self;
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        [self.dataArray removeAllObjects];
        self->currentPage = 0;
        [self getAlertsListData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 结束刷新
            [weakSelf.detailTab.mj_header endRefreshing];
        });
    }];
//    header.stateLabel.textColor = [UIColor redColor];
    self.detailTab.mj_header = header;

   
    
}
- (void)getAlertsListData{
    
    
    [HTTPTool requestDotNetWithURLString:@"et_newsflash" parameters:@{@"page":[NSString stringWithFormat:@"%d",currentPage]}    type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.model =[ETConAlertsModel mj_objectWithKeyValues:responseObject];
        [self.dataArray addObjectsFromArray:self.model.data.News];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.detailTab reloadData];
            self->currentPage++;
        });
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
- (CGFloat)getTextHeightWithString:(NSString *)string{
//    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-39, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-39, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    
  
    return  rect.size.height;
}
#pragma mark ---- 将时间戳转换成时间

- (NSString *)getTimeFromTimestamp:(NSString *)time{
    
    //将对象类型的时间转换为NSDate类型
    
//    double time =1504667976;
    
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    
    //设置时间格式
    
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    
    //将时间转换为字符串
    
    NSString *timeStr=[formatter stringFromDate:myDate];
    
    return timeStr;
    
}
#pragma mark--------DELEGATE-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count>0) {
        return self.dataArray.count+1 ;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<[self.dataArray count]) {
        ETConalertNewsListData *newsModel = self.dataArray[indexPath.row];
        CGFloat high =[self getTextHeightWithString:newsModel.content];
        NSLog(@"%f",high);
        
        if (high<100) {
            return 100+high;
        }else if(high>200){
            return 60+high;
        }else{
            return 80+high;
        }
    }else{
        return 44;
    }
   return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    //单元格ID
    //重用单元格
    
    if([indexPath row] == ([self.dataArray count])) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identy"];
        
        //创建loadMoreCell
        if (indexPath.row < [self.model.data.pages intValue]) {
            [self getAlertsListData];
            cell.textLabel.text = @"加载中";
            
        }else{
        cell.textLabel.text = @"加载完成";
        }
        return cell;
    }else{
    
    QuickViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[QuickViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
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
    
    ETConalertNewsListData *newsModel = self.dataArray[indexPath.row];
        
    NSLog(@"---%@  ===%@----%ld",newsModel,newsModel.time,(long)indexPath.row);
        cell.time.text = [self getTimeFromTimestamp:newsModel.time];
        cell.title.text = newsModel.title;
        cell.detail.text = newsModel.content;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuickViewController *ctrl = [[QuickViewController alloc]init];
//    [self setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:ctrl animated:YES];
    [self presentViewController:ctrl animated:YES completion:nil];
}
@end
