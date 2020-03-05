//
//  MineViewController.m
//  ProjectET
//
//  Created by wangxiaopeng on 2019/11/9.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "MineViewController.h"
#import "AboutUsViewController.h"
#import "MineHeadView.h"
#import "ETMyContactsController.h"
#import "InvationViewController.h"
#import "HelpViewController.h"
#import "SetViewController.h"
#import "MineRecordViewController.h"
//#import "TotalAssViewController.h"
#import "ETTotalAssetsController.h"
#import "ETWalletMangerController.h"
#import "ETInviteFriendsViewController.h"

@interface MineViewController ()<MineHeadViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *detailTab;
@property (nonatomic,strong) NSArray *imgArray;
@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation MineViewController
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
        _detailTab = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + 40, SCREEN_WIDTH, SCREEN_HEIGHT - 118) style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 26;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _detailTab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MineHeadView *view = [[MineHeadView alloc]init];
//    view.delegate = self;
//    [self.view addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_offset(0);
//        make.height.height.mas_offset(148);
//    }];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zz_top_bg"]];
    topImage.userInteractionEnabled = YES;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(120);
        
    }];
    
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.text = @"个人中心";
    titleLb.font = [UIFont systemFontOfSize:18];
    titleLb.textColor = UIColor.whiteColor;
    [topImage addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(topImage.mas_centerX);
        make.top.equalTo(topImage.mas_top).offset(kStatusBarHeight + 5);
        
    }];
    self.titleArray = @[@"联系人",@"邀请好友",@"帮助中心",@"关于我们",@"系统设置"];
    self.imgArray = @[@"wo_lian_4",@"wo_yao_5",@"wo_help_6",@"wo_guan_7",@"wo_she_8"];
    [self.view addSubview:self.detailTab];
    
    [self creatcontentView];
}

- (void)creatcontentView{
    
    UIView *tableHeadView = [ClassBaseTools viewWithBackgroundColor:[UIColor whiteColor]];
    tableHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140);
    _detailTab.tableHeaderView = tableHeadView;
    
    NSArray *btntitleArray = @[@"资产总览",@"管理钱包",@"交易记录"];
    NSArray *btnImgArray = @[@"wo_zi_1",@"wo_guan_2",@"wo_jiao_3"];
    for (int i = 0; i<3; i++) {
        UIButton *btn = [ClassBaseTools buttonWithFont:14 titlesColor:[UIColor blackColor] contentHorizontalAlignment:0 title:@"123"];
        [btn setImage:[UIImage imageNamed:btnImgArray[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(headBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [tableHeadView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(SCREEN_WIDTH/6-22+i*(SCREEN_WIDTH/3));
            make.top.mas_offset(30);
            make.width.mas_offset(44);
            make.height.mas_offset(44);
        }];
        UILabel *label = [ClassBaseTools labelWithFont:14 textColor:[UIColor blackColor] textAlignment:1];
        label.text  = btntitleArray[i];
        [tableHeadView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn);
            make.top.equalTo(btn.mas_bottom).offset(10);
        }];
    }

    UIButton *quietBtn = [ClassBaseTools buttonWithFont:16 titlesColor:UIColorFromHEX(0x1758FB, 1) contentHorizontalAlignment:0 title:@"退出登录"];
    quietBtn.hidden = YES;
    [self.view addSubview:quietBtn];
    [quietBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view.mas_centerX);
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        
    }];
    
}
- (void)headBtnAction:(UIButton *)btn{
    switch (btn.tag-1000) {
        case 0:{
            ETTotalAssetsController *ctrl = [[ETTotalAssetsController alloc]init];
            ctrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctrl animated:YES];
            
        }
            break;
        case 1:{
            ETWalletMangerController *ctrl = [[ETWalletMangerController alloc]init];
            ctrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctrl animated:YES];
   
        }
            
            break;
        case 2:{
            MineRecordViewController *ctrl = [[MineRecordViewController alloc]init];
            ctrl.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ctrl animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}
-(void)MineHeadViewDelegateWithClikTag:(NSInteger)tag{
    NSLog(@"%ld",(long)tag);
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
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
//    switch (indexPath.row) {
//        case 1:
//            return cell;
//            break;
//
//        default:
//            break;
//    }
    UIView *line = [ClassBaseTools viewWithBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.3]];
    [cell.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(50);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.width.mas_offset(SCREEN_WIDTH - 50);
        make.height.mas_offset(.5);
    }];
    UIImage *img = [UIImage imageNamed:_imgArray[indexPath.row]];
    cell.imageView.image = img;
    //添加图片
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.textLabel.textColor = UIColorFromHEX(0x333333, 1);
    //添加右侧注释
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            ETMyContactsController *ctrl = [[ETMyContactsController alloc]init];
            [ctrl setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
            break;
        case 1:{
             ETInviteFriendsViewController *ctrl = [[ETInviteFriendsViewController alloc]init];
                       [ctrl setHidesBottomBarWhenPushed:YES];
                       [self.navigationController pushViewController:ctrl animated:YES];
         }
            break;
        case 2:{
            HelpViewController *ctrl = [[HelpViewController alloc]init];
            [ctrl setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:ctrl animated:YES];

        }
            break;
        case 3:{
            AboutUsViewController *ctrl = [[AboutUsViewController alloc]init];
            [ctrl setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:ctrl animated:YES];
       
        }
            break;
        case 4:{
            SetViewController *ctrl = [[SetViewController alloc]init];
            [ctrl setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:ctrl animated:YES];
 
        }
            break;
            
        default:
            break;
    }

    
   
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imgArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
