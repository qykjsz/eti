//
//  ETFoundClassificationController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/18.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETFoundClassificationController.h"
#import "ETFoundSearchDetailCell.h"
#import "ETHTMLViewController.h"
#import "UUID.h"
#import "ETFoundCategoryModel.h"

@interface ETFoundClassificationController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@end

@implementation ETFoundClassificationController

- (void)setOffsetY:(CGFloat)offsetY{
    self.detailTab.contentOffset = CGPointMake(0, offsetY);
}

- (CGFloat)offsetY{
    return self.detailTab.contentOffset.y;
}

- (void)setIsCanScroll:(BOOL)isCanScroll{
    if (isCanScroll == YES){
        [self.detailTab setContentOffset:CGPointMake(0, self.offsetY) animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.scrollDelegate respondsToSelector:@selector(hoverChildViewController:scrollViewDidScroll:)]){
        [self.scrollDelegate hoverChildViewController:self scrollViewDidScroll:scrollView];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:self.detailTab];
     NSLog(@"%f",self.detailTab.frame.size.height);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = 
//    [self.view addSubview:self.detailTab];
    WEAK_SELF(self);
//    [self.detailTab mas_makeConstraints:^(MASConstraintMaker *make) {
//        STRONG_SELF(self);
//        make.edges.equalTo(self.view);
//    }];
    
  
}

#pragma mark - 记录最近使用
- (void)et_appnewRequest:(NSString *)ID {
    
    NSString *uuidString = [UUID getUUID];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:ID forKey:@"appid"];
    [dict setValue:uuidString forKey:@"contacts"];
    [HTTPTool requestDotNetWithURLString:@"et_appnew" parameters:dict type:kPOST success:^(id responseObject) {
        
//        [self et_appnewsRequest];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETFoundSearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETFoundSearchDetailCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.appModel = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 73;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ETFoundDetailData *data = self.detailData[indexPath.row];
    
    FoundCategoryApps *data = self.data[indexPath.row];
    [self et_appnewRequest:data.Id];
    if ([data.types isEqualToString:@"2"]) {
                NSURL *url = [NSURL URLWithString:data.ios];
                BOOL isCanOpen = [[UIApplication sharedApplication] canOpenURL:url];
                if (isCanOpen) {
        #ifdef NSFoundationVersionNumber_iOS_10_0
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                        
                    }];
        #else
                    [[UIApplication sharedApplication] openURL:url];
        #endif
                    NSLog(@"App1打开App2");
                }else{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data.url]options:@{} completionHandler:^(BOOL success) {
                        
                    }];
                }
    }else {
        ETHTMLViewController *vc = [ETHTMLViewController new];
           vc.url = data.url;
           vc.title = data.name;
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:true];
    }
    
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_detailTab registerNib:[UINib nibWithNibName:@"ETFoundSearchDetailCell" bundle:nil] forCellReuseIdentifier:@"ETFoundSearchDetailCell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
        
    }
    return _detailTab;
}

@end
