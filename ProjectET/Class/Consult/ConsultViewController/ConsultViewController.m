//
//  ConsultViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/10.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ConsultViewController.h"
#import "ConsultHeadView.h"
#import "RCSegmentView.h"
#import "AlertsViewController.h"
#import "ArticleViewController.h"
#import "MarketViewController.h"


@interface ConsultViewController ()
//<ConsultHeadViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation ConsultViewController
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
    self.title = @"资讯";
    
    
    UIView *topView = [ClassBaseTools viewWithBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wo_top_bg"]]];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.width.mas_offset(SCREEN_WIDTH);
        make.height.mas_offset(168);
    }];
    
    AlertsViewController *alet = [[AlertsViewController alloc]init];
    ArticleViewController *article = [[ArticleViewController alloc]init];
    MarketViewController *mark = [[MarketViewController alloc]init];
    
    NSArray *array = @[alet,article,mark];
    RCSegmentView *rcVc = [[RCSegmentView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight-kTabBarHeight) controllers:array titleArray:@[@"快讯",@"文章",@"行情"] ParentController:self];
    rcVc.layer.masksToBounds = YES;
    rcVc.layer.cornerRadius = 26;
    [self.view addSubview:rcVc];
}
//- (UITableView *)detailTab {
//
//    if (!_detailTab) {
//        _detailTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 118, SCREEN_WIDTH, SCREEN_HEIGHT-118) style:UITableViewStylePlain];
//        _detailTab.delegate = self;
//        _detailTab.dataSource = self;
//        _detailTab.clipsToBounds = YES;
//        _detailTab.layer.cornerRadius = 26;
//        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _detailTab.backgroundColor = [UIColor whiteColor];
//    }
//    return _detailTab;
//}
//-(void)ConsultHeadViewDelegateWithClikTag:(NSInteger)tag{
//    NSLog(@"%ld",(long)tag);
//}
//#pragma mark--------DELEGATE-------------
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *CellTableIndentifier = @"CellTableIdentifier";
//    //单元格ID
//    //重用单元格
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
//    //初始化单元格
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
//        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
//    }
//    UIView *line = [ClassBaseTools viewWithBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.3]];
//    [cell.contentView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(15);
//        make.bottom.equalTo(cell.contentView.mas_bottom);
//        make.width.mas_offset(SCREEN_WIDTH);
//        make.height.mas_offset(.5);
//    }];
//
//    cell.textLabel.text = @"123";
//    cell.textLabel.font =[UIFont systemFontOfSize:14];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

@end
