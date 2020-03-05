//
//  ETNewChatCreateGroupViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatCreateGroupViewController.h"
#import "ETNewChatAddressBookModel.h"
#import "ETNewChatCreateGroupCell.h"
#import "ETNewChatConfirmGroupViewController.h"


@interface ETNewChatCreateGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *tf_search;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic,strong)ETNewChatAddressBookModel *model;


@end

@implementation ETNewChatCreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择联系人";
    self.dataSource = [NSMutableArray array];
    [self.tf_search setEnabled:false];
    [self.tableView registerNib:[UINib nibWithNibName:@"ETNewChatCreateGroupCell" bundle:nil] forCellReuseIdentifier:@"ETNewChatCreateGroupCell"];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 52, 28);
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    rightBtn.backgroundColor = UIColorFromHEX(0x1D57FF, 1);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    rightBtn.layer.cornerRadius = 3;
    rightBtn.layer.masksToBounds = YES;
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self getRongyunMyfriends];
    // Do any additional setup after loading the view from its nib.
}

///还有列表
- (void)getRongyunMyfriends{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_myfriends" parameters:@{@"uid":model.ryID} type:kPOST success:^(id responseObject) {
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
                NSArray *muarr = self.model.data[sortArray[i]];
                NSMutableArray *nsmuArr = [NSMutableArray array];
                for (int j = 0; j < muarr.count; j++) {
                    NSMutableDictionary *mudic = [[NSMutableDictionary alloc]init];
                    [mudic setDictionary:muarr[j]];
                    [mudic setObject:@"0" forKey:@"sel"];
                    [nsmuArr addObject:mudic];
                }
                NSDictionary *dict = @{@"name":sortArray[i],@"dataSource":nsmuArr};
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


///添加群成员
- (void)getrongyunAddgropuser:(NSString *)ids{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_addgropuser" parameters:@{@"uid":model.ryID,@"tid":ids,@"qid":self.tid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            
            [self.navigationController popViewControllerAnimated:true];
        }
        [KMPProgressHUD showText:baseModel.msg];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}

///移除群成员
- (void)getrongyunDelgropuser:(NSString *)ids{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_delgropuser_foradmin" parameters:@{@"uid":model.ryID,@"tid":ids,@"qid":self.tid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            
            [self.navigationController popViewControllerAnimated:true];
        }
        [KMPProgressHUD showText:baseModel.msg];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}

- (void)rightBtnAction{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.dataSource.count; i++) {
        NSMutableDictionary *dic = self.dataSource[i];
        NSArray *arr1 = dic[@"dataSource"];
        for (int j = 0; j < arr1.count; j++) {
            NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
            [dic2 setDictionary:arr1[j]];
            if ([dic2[@"sel"] isEqualToString:@"1"]) {
                [arr addObject:dic2[@"id"]];
            }
        }
    }
    if (self.type == 0) {
        if (arr.count <= 1) {
              [KMPProgressHUD showText:@"群组至少三人"];
              return;
          }
        NSString *string = [arr componentsJoinedByString:@","];
        ETNewChatConfirmGroupViewController *vc = [ETNewChatConfirmGroupViewController new];
        vc.ids = string;
        [self.navigationController pushViewController:vc animated:true];
    }else if (self.type == 1) {
        if (arr.count <= 0) {
            [KMPProgressHUD showText:@"请选择成员"];
            return;
        }
         NSString *string = [arr componentsJoinedByString:@","];
        [self getrongyunAddgropuser:string];
    }else if (self.type == 2) {
        if (arr.count <= 0) {
            [KMPProgressHUD showText:@"请选择成员"];
            return;
        }
        NSString *string = [arr componentsJoinedByString:@","];
        [self getrongyunDelgropuser:string];
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
    
    ETNewChatCreateGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETNewChatCreateGroupCell"];
    
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

    if (self.type == 0) {
        NSMutableDictionary *dic = self.dataSource[indexPath.section];
        NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
        [dic2 setDictionary:dic[@"dataSource"][indexPath.row]];
        if ([dic2[@"sel"] isEqualToString:@"0"]) {
            dic2[@"sel"] = @"1";
        }else {
            dic2[@"sel"] = @"0";
        }
        self.dataSource[indexPath.section][@"dataSource"][indexPath.row] = dic2;
        [self.tableView reloadData];
    }else if (self.type == 1) {

        
        for (int i = 0; i < self.dataSource.count; i++) {
               NSMutableDictionary *dic = self.dataSource[i];
               NSArray *arr1 = dic[@"dataSource"];
               for (int j = 0; j < arr1.count; j++) {
                   NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
                   [dic2 setDictionary:arr1[j]];
                   dic2[@"sel"] = @"0";
                   self.dataSource[i][@"dataSource"][j] = dic2;
               }
           }
        
                NSMutableDictionary *dic = self.dataSource[indexPath.section];
                NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
        [dic2 setDictionary:dic[@"dataSource"][indexPath.row]];
                dic2[@"sel"] = @"1";
                self.dataSource[indexPath.section][@"dataSource"][indexPath.row] = dic2;
                [self.tableView reloadData];
    }else if (self.type == 2) {
        
        for (int i = 0; i < self.dataSource.count; i++) {
               NSMutableDictionary *dic = self.dataSource[i];
               NSArray *arr1 = dic[@"dataSource"];
               for (int j = 0; j < arr1.count; j++) {
                   NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
                   [dic2 setDictionary:arr1[j]];
                   dic2[@"sel"] = @"0";
                   self.dataSource[i][@"dataSource"][j] = dic2;
               }
           }
        
                NSMutableDictionary *dic = self.dataSource[indexPath.section];
                NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
        [dic2 setDictionary:dic[@"dataSource"][indexPath.row]];
                dic2[@"sel"] = @"1";
                self.dataSource[indexPath.section][@"dataSource"][indexPath.row] = dic2;
                [self.tableView reloadData];
        
       
    }
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
