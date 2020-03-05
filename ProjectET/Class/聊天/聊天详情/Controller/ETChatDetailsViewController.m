//
//  ETChatDetailsViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/6.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETChatDetailsViewController.h"
#import "MeTableViewCell.h"
#import "OtherTableViewCell.h"
#import "ETSocketHelper.h"
#import "ETChatDetailsModel.h"
@interface ETChatDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITextField *tf_msg;
@property (nonatomic, strong) ETChatDetailsModel *model;
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic,strong) CustomGifHeader *gifHeader;
@property (weak, nonatomic) IBOutlet UIButton *btn_send;
@property (nonatomic,assign) NSInteger dataCount;
@end

@implementation ETChatDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    self.currentPage = 0;
    self.tableView.estimatedRowHeight = 150;
      self.tableView.backgroundColor = UIColorFromHEX(0xEBEBEB, 1);
    self.dataSource = [NSMutableArray array];
    [self.tableView registerClass:[MeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MeTableViewCell class])];
    [self.tableView registerClass:[OtherTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OtherTableViewCell class])];
    [self socketLine];
    self.tableView.mj_header = self.gifHeader;
    [self getChatingorder];
    // Do any additional setup after loading the view from its nib.
}

- (void)socketLine{
    ETWalletModel *model1 = [ETWalletManger getCurrentWallet];
    [[ETSocketHelper sharedSocketHelper] socketRequest:@"http://47.244.50.67:2569" AndKey:@"refresh" success:^(id  _Nonnull responseObject) {
        ETChatDetailsChatModel *model =[ETChatDetailsChatModel mj_objectWithKeyValues:responseObject];
        
        if ([model.fromwho isEqualToString:model1.address] || [model.towho isEqualToString:model1.address]) {
            [self.dataSource insertObject:model atIndex:self.dataSource.count];
            self.dataCount = self.dataSource.count - 1;
            [self.tableView reloadData];
               NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0  inSection:self.dataCount];
                     [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

///搜索好友
- (void)getTochating{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"tochating" parameters:@{@"fromwho":model.address,@"towho":self.toAddress,@"text":self.tf_msg.text} type:kPOST success:^(id responseObject) {
        
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        [self.btn_send setEnabled:true];
        if (baseModel.code == 200) {
          
            self.tf_msg.text = @"";
        }else{
            [KMPProgressHUD showText:baseModel.msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
          [self.btn_send setEnabled:true];
        
    }];
}


///新聊天列表
- (void)getChatingorder{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    //    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"chatingorder" parameters:@{@"fromwho":model.address,@"towho":self.toAddress,@"page":[NSString stringWithFormat:@"%ld",(long)self.currentPage]} type:kPOST success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            if (self.currentPage == 0 || self.dataSource.count == 0) {
                [self.dataSource removeAllObjects];
                self.model =[ETChatDetailsModel mj_objectWithKeyValues:responseObject];
                [self.dataSource addObjectsFromArray:self.model.data.chat];
                self.dataSource = (NSMutableArray *)[[self.dataSource reverseObjectEnumerator] allObjects];
                self.dataCount = self.dataSource.count-1;
                [self.tableView reloadData];
                if(self.dataSource.count > 0){
                    
                        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0  inSection:self.dataCount];
                                   
                                   [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                    
                }
                
            }else{
                self.model =[ETChatDetailsModel mj_objectWithKeyValues:responseObject];
                for (int i = 0; i < self.model.data.chat.count; i++) {
                    ETChatDetailsChatModel *chatModel = self.model.data.chat[self.model.data.chat.count - 1 - i];
                    [self.dataSource insertObject:chatModel atIndex:0];
                }
                [self.tableView reloadData];
                self.dataCount = self.model.data.chat.count;
                   NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0  inSection:self.dataCount];
                            
                            [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            
            
        }
        //        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
        //        [SVProgressHUD dismiss];
    }];
}



///发送
- (IBAction)actionOfSend:(UIButton *)sender {
      [self.btn_send setEnabled:false];
    [self getTochating];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    ETChatDetailsChatModel *chatModel = self.dataSource[indexPath.section];
    
    if ([chatModel.fromwho isEqualToString:model.address]) {
        
        MeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeTableViewCell class])];
        cell.nameLabel.text= chatModel.fromname;
        cell.contentLabel.text= chatModel.text;
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:chatModel.fromphoto]];
        return cell;
        
    }else{
        
        OtherTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OtherTableViewCell class])];
        cell.nameLabel.text= chatModel.fromname;
        cell.contentLabel.text= chatModel.text;
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:chatModel.fromphoto]];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ETChatDetailsChatModel *chatModel = self.dataSource[indexPath.section];
    NSString *str= chatModel.text;
    
    CGFloat width=[UIScreen mainScreen].bounds.size.width-15-50-8-12-100;
    
    CGRect frame=[str boundingRectWithSize:CGSizeMake(width, 9999999999) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    CGFloat height=frame.size.height+70;
    
    if (height<70) {
        return 70;
    }else{
        return height;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ETChatDetailsChatModel *chatModel = self.dataSource[section];
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 30)];
    sectionView.backgroundColor = UIColorFromHEX(0xEBEBEB, 1);
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    lab.textColor = UIColorFromHEX(0x999999, 1);
    lab.font = [UIFont systemFontOfSize:11];
    lab.text = [Tools dateToString: [NSDate dateWithTimeIntervalSince1970:[chatModel.time intValue]]];
    lab.textAlignment = NSTextAlignmentCenter;
    [sectionView addSubview:lab];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CustomGifHeader *)gifHeader {
    if (!_gifHeader) {
        WEAK_SELF(self);
        _gifHeader = [CustomGifHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                STRONG_SELF(self);
                self.currentPage += 1;
                [self getChatingorder];
            });
        }];
    }
    return _gifHeader;
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
