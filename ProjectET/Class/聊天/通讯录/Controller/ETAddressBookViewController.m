//
//  ETAddressBookViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/2.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETAddressBookViewController.h"
#import "ETAddressBookCell.h"
#import "ETAddressBookHeaderView.h"
#import "ETAddressBookModel.h"
#import "ETChatDetailsViewController.h"
#import "ETChatGroupDetailsViewController.h"
#import "ETShopChooseCoinView.h"
#import "ETFriendAndGroupCodeViewController.h"
@interface ETAddressBookViewController ()<UITableViewDelegate,UITableViewDataSource,ETAddressBookHeaderViewDelegate,ETShopChooseCoinViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ETAddressBookHeaderView *headerView;
@property (nonatomic,strong)ETAddressBookModel *model;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSDictionary *userDic;
@end

@implementation ETAddressBookViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.type isEqualToString:@"1"]) {
          [self getChatGroupusers:@""];
      }else {
          [self getChatgrouplist:@""];
      }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    self.type = @"1";
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"ETAddressBookCell" bundle:nil] forCellReuseIdentifier:@"ETAddressBookCell"];
    self.headerView = [[ETAddressBookHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.delegate = self;
    [self getChatSelusername];
//    [self getChatGroupusers:@""];
    // Do any additional setup after loading the view from its nib.
}


///搜索好友
- (void)getChatSelusername{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"selusername" parameters:@{@"address":model.address} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.headerView.lab_address.text = [NSString stringWithFormat: @"账号：%@",responseObject[@"data"][@"address"]];
            self.headerView.tf_name.text = [NSString stringWithFormat: @"%@",responseObject[@"data"][@"name"]];
            [self.headerView.img_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@",responseObject[@"data"][@"photo"]]]];
             self.userDic = @{@"chatCode":[NSString stringWithFormat:@"%@", responseObject[@"data"][@"address"]]};
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}
///好友列表
- (void)getChatGroupusers:(NSString *)selectaddress{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"chatfriend_order" parameters:@{@"fromwho":model.address,@"selectaddress":selectaddress}    type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        [self.dataSource removeAllObjects];
        if (baseModel.code == 200) {
            self.model =[ETAddressBookModel mj_objectWithKeyValues:responseObject];
            [self.dataSource addObjectsFromArray:self.model.data];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.dataSource removeAllObjects];
        [self.tableView reloadData];
    }];
}

///组群列表
- (void)getChatgrouplist:(NSString *)selectqcode{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"grouplist" parameters:@{@"address":model.address,@"selectqcode":selectqcode}    type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        [self.dataSource removeAllObjects];
        if (baseModel.code == 200) {
            self.model =[ETAddressBookModel mj_objectWithKeyValues:responseObject];
            [self.dataSource addObjectsFromArray:self.model.data];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
         [self.dataSource removeAllObjects];
        [self.tableView reloadData];
    }];
}

///修改昵称
- (void)getChatSelusername:(NSString *)name{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"upchatusername" parameters:@{@"address":model.address,@"name":name} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            
        }else{
            
        }
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}

- (void)getChatChangeHeaderImg:(UIImage *)image {
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSData *data = UIImageJPEGRepresentation(image, 0.5f);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    
    [manager POST:[NSString stringWithFormat:@"%@upuserphone",APP_DOMAIN] parameters:@{@"address":model.address} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"userphone" fileName:@"userphone.jpg" mimeType:@"image/jpg"];
    
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         self.headerView.img_img.image = image;
        NSLog(@"%@",JSON[@"msg"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
    }];
}



#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ETAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETAddressBookCell"];
    cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.lab_num.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.type isEqualToString:@"1"]) {
        ETChatDetailsViewController *vc = [ETChatDetailsViewController new];
        ETAddressBookDataModel *model = self.dataSource[indexPath.row];
        vc.toAddress = model.address;
        vc.name = model.name;
        [self.navigationController pushViewController:vc animated:true];
    }else {
        ETChatGroupDetailsViewController *vc = [ETChatGroupDetailsViewController new];
        ETAddressBookDataModel *model = self.dataSource[indexPath.row];
        vc.qcode = model.code;
        vc.name = model.name;
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


#pragma mark - ETAddressBookHeaderViewDelegate

- (void)ETAddressBookHeaderViewFriendAndGroupDelegate:(NSInteger)type {
    self.type = [NSString stringWithFormat:@"%ld",type];
    if (type == 1) {
        [self getChatGroupusers:@""];
    }else {
        [self getChatgrouplist:@""];
    }
}

- (void)ETAddressBookHeaderViewChangeNameDelegate:(NSString *)name{
    [self getChatSelusername:name];
}

- (void)ETAddressBookHeaderViewChangeHeaderImgDelegate{
    ETShopChooseCoinView *chooseView = [[ETShopChooseCoinView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    chooseView.lab_title.text = @"选择";
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@{@"name":@"拍照"},@{@"name":@"从相册选择"}]];
    chooseView.delegate = self;
    [chooseView reloadChooseView:arr];
    [chooseView show];
}

- (void)ETAddressBookHeaderViewUserInfoCodeDelegate{
    ETFriendAndGroupCodeViewController *vc = [ETFriendAndGroupCodeViewController new];
    vc.dic = self.userDic;
    vc.flag = YES;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)ETAddressBookHeaderViewSearchDelegate:(NSString *)address{
    if ([self.type isEqualToString:@"1"]) {
        [self getChatGroupusers:address];
    }else {
        [self getChatgrouplist:address];
    }
}


#pragma mark - ETShopChooseCoinViewDelegate
- (void)ETShopChooseCoinViewDelegateWithCell:(NSInteger)index{
    if (index == 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    UIImage *newImage = [self originImage:image scaleToSize:CGSizeMake(image.size.width, image.size.width)];
    
    [self getChatChangeHeaderImg:newImage];
  
    
    [picker dismissViewControllerAnimated:YES completion:^{}];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
     
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
     
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
     
    UIGraphicsEndImageContext();
     
    return scaledImage;   //返回的就是已经改变的图片
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
