//
//  ETRecordDetailViewController.m
//  ProjectET
//
//  Created by hufeng on 2019/11/1.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETRecordDetailViewController.h"
#import "ETTransferDetailViewController.h"

#import "ETRecordHeaderView.h"
#import "ETRecordCell.h"

#import "ETMyContactsCell.h"
@interface ETRecordDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTab;

@property (nonatomic,assign) BOOL isOpen;

@end

@implementation ETRecordDetailViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isOpen = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eyeAction:) name:@"RECODEREYEACTION" object:nil];
    
    self.detailTab.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-85);
    
    [self.view addSubview:self.detailTab];
    
}


#pragma mark - Noticfication
- (void)eyeAction:(NSNotification *)sender {
    
    if ([sender.object[@"isOpen"] boolValue]) {
        
        self.isOpen = YES;
    }else {
        
        self.isOpen = NO;
        
    }
    
    [self.detailTab reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 12;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 98;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETRecordCell"];
    if (self.isOpen) {
        cell.moneydetail.text = @"289.8493";
        cell.statusDetail.text = @"已完成";
        cell.timeDetail.text = @"2019/10/22 12:23";
    }else {
        cell.moneydetail.text = @"***.**";
        cell.statusDetail.text = @"***";
        cell.timeDetail.text = @"****/**/** **:**";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ETTransferDetailViewController *tVC = [ETTransferDetailViewController new];
    [self.navigationController pushViewController:tVC animated:YES];
}

#pragma mark - lazy load
- (UITableView *)detailTab {
    
    if (!_detailTab) {
        _detailTab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTab.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_detailTab registerClass:[ETRecordCell class] forCellReuseIdentifier:@"ETRecordCell"];
        _detailTab.clipsToBounds = YES;
        _detailTab.layer.cornerRadius = 25;
    }
    return _detailTab;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
