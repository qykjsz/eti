//
//  ETNewChatAddressBookViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatAddressBookViewController.h"
#import "ETNewChatMineGroupViewController.h"
#import "ETNewChatNewFriendViewController.h"
#import "ETNewChatAddressFriendMsgViewController.h"

#import "ETNewChatAddressCell.h"
#import "ETNewChatAddressBookModel.h"
#import "ETNewChatNewFriendModel.h"
#import <RongIMKit/RongIMKit.h>

@interface ETNewChatAddressBookViewController ()<UITableViewDelegate,UITableViewDataSource,ETNewChatHeaderViewDelegate,RCIMReceiveMessageDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic,strong)ETNewChatAddressBookModel *model;

@property (weak, nonatomic) IBOutlet UITextField *tf_search;

@property (nonatomic,strong)ETNewChatNewFriendModel *model2;

@property (nonatomic, strong)ETNewChatHeaderView *headerView;

@end

@implementation ETNewChatAddressBookViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self getRongyunMyfriends];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    self.dataSource = [NSMutableArray array];
    self.headerView = [[ETNewChatHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
     [self.tableView registerNib:[UINib nibWithNibName:@"ETNewChatAddressCell" bundle:nil] forCellReuseIdentifier:@"ETNewChatAddressCell"];
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.delegate = self;
    [self.tf_search setEnabled:false];
    
    // Do any additional setup after loading the view from its nib.
}


///还有列表
- (void)getRongyunMyfriends{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_myfriends" parameters:@{@"uid":[NSString stringWithFormat:@"%@",model.ryID]} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            [self.dataSource removeAllObjects];
            NSDictionary *dic = responseObject[@"data"];
            if (dic.count == 0) {
                  [self.tableView reloadData];
                return ;
            }
            NSArray *arr = dic.allKeys;
            NSArray *sortArray = [arr sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
            }];
            self.model = [ETNewChatAddressBookModel mj_objectWithKeyValues:responseObject];
            for (int i = 0; i < sortArray.count; i++) {
                NSDictionary *dict = @{@"name":sortArray[i],@"dataSource":self.model.data[sortArray[i]]};
                [self.dataSource addObject:dict];
            }
            [self.tableView reloadData];
            
        }else{
            [KMPProgressHUD showText:baseModel.msg];
//            [self.navigationController popViewControllerAnimated:true];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
}

#pragma mark - ETNewChatHeaderViewDelegate
- (void)ETNewChatHeaderViewDelegate:(NSInteger)tag{
    if (tag == 0) {
        [self.headerView.img_p setHidden:true];
        ETNewChatNewFriendViewController *vc = [ETNewChatNewFriendViewController new];
        vc.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:vc animated:true];
    }else {
        ETNewChatMineGroupViewController *vc = [ETNewChatMineGroupViewController new];
        vc.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:vc animated:true];
    }
}

#pragma mark - RCIMReceiveMessageDelegate
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    if (message.conversationType == ConversationType_SYSTEM) {
            RCTextMessage*textMsg = (RCTextMessage *)message.content;
        NSLog(@"新消息==%@附加消息==%@",textMsg.content,textMsg.extra);
        NSDictionary *dic = [Tools dictionaryWithJsonString:textMsg.extra];
        if ([[NSString stringWithFormat:@"%@",dic[@"type"]] isEqualToString:@"1"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.headerView.img_p setHidden:false];
            });
            
        }
    }

   
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [self.dataSource[section][@"dataSource"] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETNewChatAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETNewChatAddressCell"];
    
    NSDictionary *dic = self.dataSource[indexPath.section];
    [cell reloadCellForDic:dic[@"dataSource"][indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.lab_num.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *dic = self.dataSource[indexPath.section];
    ETNewChatAddressFriendMsgViewController *vc = [ETNewChatAddressFriendMsgViewController new];
    vc.uid = [NSString stringWithFormat:@"%@",dic[@"dataSource"][indexPath.row][@"id"]] ;
    vc.remarks = [NSString stringWithFormat:@"%@",dic[@"dataSource"][indexPath.row][@"remarks"]] ;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:true];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.dataSource.count == 0) {
        return 0.1;
    }else {
        return 27;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 27)];
    sectionView.backgroundColor = UIColorFromHEX(0xEBEBEB, 1);
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 27)];
    lab.textColor = UIColorFromHEX(0x999999, 1);
    lab.font = [UIFont systemFontOfSize:11];
    lab.text = self.dataSource[section][@"name"];
    [sectionView addSubview:lab];
    return sectionView;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in self.dataSource) {
        [arr addObject:dic[@"name"]];
    }
    return arr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
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
