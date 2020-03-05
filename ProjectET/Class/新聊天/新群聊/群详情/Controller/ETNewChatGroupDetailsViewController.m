//
//  ETNewChatGroupDetailsViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatGroupDetailsViewController.h"
#import "ETNewChatGroupDetailsModel.h"
#import "ETNewChatGroupDetailsCell.h"
#import "ETNewChatChangeGroupNameViewController.h"
#import "ETNewChatGroupRemarkViewController.h"
#import "ETShopChooseCoinView.h"
#import "ETNewChatGroupCodeViewController.h"
#import "ETNewChatCreateGroupViewController.h"
#import "ETNewChatGroupUserViewController.h"
#import "CTRongManager.h"
#import "ETNewChatDelGroupView.h"
#import <RongIMKit/RongIMKit.h>
#import "ETNewChatMineGroupViewController.h"
@interface ETNewChatGroupDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate, UINavigationControllerDelegate,ETShopChooseCoinViewDelegate,ETNewChatDelGroupViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_ViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic,strong)ETNewChatGroupDetailsModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_qid;
@property (weak, nonatomic) IBOutlet UILabel *lab_groupName;
@property (weak, nonatomic) IBOutlet UILabel *lab_groupRemark;
@property (nonatomic, strong) NSString *qzid;
@property (nonatomic, assign) NSInteger type;
@property (weak, nonatomic) IBOutlet UIButton *btn_del;

@property (nonatomic, strong) NSString *remark;
@property (weak, nonatomic) IBOutlet UISwitch *switch_save;

@end

@implementation ETNewChatGroupDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getrongyunGroup];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [HYNRCDData refrechCircleGroup:self.tid];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群聊信息";
    self.dataSource = [NSMutableArray array];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ETNewChatGroupDetailsCell" bundle:nil] forCellWithReuseIdentifier:@"ETNewChatGroupDetailsCell"];
    [self layoutCollectionView];
    
    self.lab_qid.text = self.tid;
    // Do any additional setup after loading the view from its nib.
}


///0:头像 1:群名称 2:群分享 3:群ID 4:群简介 5:管理
- (IBAction)actionOfFuntion:(UIButton *)sender {
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    if (sender.tag - 600 == 0) {
        if (![model.ryID isEqualToString:self.qzid]) {
            [KMPProgressHUD showText:@"您不是群主，没有权限"];
            return;
        }
        self.type = 0;
        ETShopChooseCoinView *chooseView = [[ETShopChooseCoinView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        chooseView.lab_title.text = @"选择";
        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@{@"name":@"拍照"},@{@"name":@"从相册选择"}]];
        chooseView.delegate = self;
        [chooseView reloadChooseView:arr];
        [chooseView show];
    }else  if (sender.tag - 600 == 1) {
        if (![model.ryID isEqualToString:self.qzid]) {
            [KMPProgressHUD showText:@"您不是群主，没有权限"];
            return;
        }
        ETNewChatChangeGroupNameViewController *vc = [ETNewChatChangeGroupNameViewController new];
        vc.tid = self.tid;
        vc.qname = self.lab_groupName.text;
        [self.navigationController pushViewController:vc animated:true];
    }else if (sender.tag - 600 == 2){
        ETNewChatGroupCodeViewController *vc = [ETNewChatGroupCodeViewController new];
        vc.tid = self.tid;
        [self.navigationController pushViewController:vc animated:true];
    }else if (sender.tag - 600 == 3){
        
        
    }else if (sender.tag - 600 == 4){
        ETNewChatGroupRemarkViewController *vc = [ETNewChatGroupRemarkViewController new];
        vc.tid = self.tid;
        vc.remark = self.remark;
        [self.navigationController pushViewController:vc animated:true];
    }
}


- (IBAction)actionOfSaveGroup:(UISwitch *)sender {
    if (sender.isOn != true) {
        
        [self getRongyunDelmygroups];
    }else {
        [self getrongyunAddmygroups];
    }
    
}


- (IBAction)actionOfMoreUser:(UIButton *)sender {
    ETNewChatGroupUserViewController *vc = [ETNewChatGroupUserViewController new];
    vc.qzid = self.qzid;
    vc.tid = self.tid;
    [self.navigationController pushViewController:vc animated:true];
}

///解散并推出
- (IBAction)actionOfDel:(UIButton *)sender {
    
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    if ([model.ryID isEqualToString:self.qzid]) {
        self.type = 1;
        ETNewChatDelGroupView *delView = [[ETNewChatDelGroupView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        delView.lab_title.text = @"退出后不会通知群聊中其他成员，且群将会解散不会在 收到此群聊的消息";
        delView.delegate = self;
        [delView show];
    }else{
        self.type = 2;
        ETNewChatDelGroupView *delView = [[ETNewChatDelGroupView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        delView.lab_title.text = @"退出后不会通知群聊中其他成员，且不会再收到此群聊的消息";
        delView.delegate = self;
        [delView show];
    }
    
}


- (void)layoutCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 20);
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 120)/5, 80);
    [self.collectionView setCollectionViewLayout:layout];
}


///移除群通讯录
- (void)getRongyunDelmygroups{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_delmygroups" parameters:@{@"uid":model.ryID,@"qid":self.tid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            
        }
        
        [KMPProgressHUD showText:baseModel.msg];
    } failure:^(NSError *error) {
    }];
}


///好友列表
- (void)getChatGroupusers{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_groupsuser" parameters:@{@"qid":self.tid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        [self.dataSource removeAllObjects];
        if (baseModel.code == 200) {
            self.model =[ETNewChatGroupDetailsModel mj_objectWithKeyValues:responseObject];
            [self.dataSource addObjectsFromArray:self.model.data];
            self.title = [NSString stringWithFormat:@"群聊信息(%ld)",self.dataSource.count];
            if (self.dataSource.count > 13) {
                [self.dataSource removeObjectsInRange:NSMakeRange(13, self.dataSource.count - 13)];
            }
            
            ETNewChatGroupDetailsDataModel *model1 = [ETNewChatGroupDetailsDataModel new];
            model1.photo = @"lt_tjyqhy";
            model1.name = @"";
            [self.dataSource addObject:model1];
            if ([model.ryID isEqualToString:self.qzid]) {
                ETNewChatGroupDetailsDataModel *model2 = [ETNewChatGroupDetailsDataModel new];
                model2.photo = @"lt_scqy";
                model2.name = @"";
                [self.dataSource addObject:model2];
            }
            
            
            
            if (self.dataSource.count <= 5) {
                self.constraint_ViewHeight.constant = 160;
            }else if (self.dataSource.count <=10){
                self.constraint_ViewHeight.constant = (160 - 40) * 2;
            }else {
                self.constraint_ViewHeight.constant = (160 - 40) * 3;
            }
            
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.dataSource removeAllObjects];
        //        [self.tableView reloadData];
    }];
}

///修改头像
- (void)getChatChangeHeaderImg:(UIImage *)image {
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    NSData *data = UIImageJPEGRepresentation(image, 0.5f);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    
    [manager POST:[NSString stringWithFormat:@"%@rongyun_upgroupphpoto",APP_DOMAIN] parameters:@{@"uid":[NSString stringWithFormat:@"%@",model.ryID],@"qid":self.tid} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"photo" fileName:@"photo.jpg" mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        self.img_img.image = image;
        NSLog(@"%@",JSON[@"msg"]);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

///修改昵称
- (void)getrongyunDelmygroups{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_dismissgroup" parameters:@{@"uid":model.ryID,@"qid":self.tid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
                   if ([self.fromGroupType isEqualToString:@"1"]) {
                     ETNewChatMineGroupViewController *vc = [ETNewChatMineGroupViewController new];
                     vc.hidesBottomBarWhenPushed = YES;
                     NSMutableArray *vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
                     [vcs removeLastObject];
                     [vcs removeLastObject];
                     [vcs removeLastObject];
                     [vcs addObject:vc];
                     [self.navigationController setViewControllers:vcs];
                 }else {
                     [self.navigationController popToRootViewControllerAnimated:true];
                 }
                 
        }
        [KMPProgressHUD showText:baseModel.msg];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


///修改昵称
- (void)getrongyunAddmygroups{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_addmygroups" parameters:@{@"uid":model.ryID,@"qid":self.tid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            
        }
        [KMPProgressHUD showText:baseModel.msg];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


///修改昵称
- (void)getrongyunDelgropuserForuser{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_delgropuser_foruser" parameters:@{@"uid":model.ryID,@"qid":self.tid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            if ([self.fromGroupType isEqualToString:@"1"]) {
                ETNewChatMineGroupViewController *vc = [ETNewChatMineGroupViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                NSMutableArray *vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
                [vcs removeLastObject];
                [vcs removeLastObject];
                [vcs removeLastObject];
                [vcs addObject:vc];
                [self.navigationController setViewControllers:vcs];
            }else {
                [self.navigationController popToRootViewControllerAnimated:true];
            }
            
        }
        [KMPProgressHUD showText:baseModel.msg];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


///修改昵称
- (void)getrongyunGroup{
    //    [SVProgressHUD showWithStatus:@""];
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [HTTPTool requestDotNetWithURLString:@"rongyun_group" parameters:@{@"qid":self.tid,@"uid":model.ryID} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            
            self.lab_qid.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"id"]];
            self.lab_groupName.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
            [self.img_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]]]];
            if ([[NSString stringWithFormat:@"%@",responseObject[@"data"][@"introduce"]] isEqualToString:@""]) {
                self.lab_groupRemark.text = @"未设置";
            }else {
                self.lab_groupRemark.text = @"已设置";
            }
            
            if ([[NSString stringWithFormat:@"%@",responseObject[@"data"][@"is_hold"]] isEqualToString:@"1"]) {
                [self.switch_save setOn:YES];
            }else {
                [self.switch_save setOn:NO];
            }
            
            self.qzid =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"qzid"]];
            if ([self.qzid isEqualToString:model.ryID]) {
                [self.btn_del setTitle:@"解散并退出" forState:UIControlStateNormal];
            }else {
                [self.btn_del setTitle:@"删除并退出" forState:UIControlStateNormal];
            }
            self.remark  = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"introduce"]];
            [self getChatGroupusers];
        }else {
            [self.navigationController popToRootViewControllerAnimated:true];
           [KMPProgressHUD showText:baseModel.msg];
        }
        //        [KMPProgressHUD showText:baseModel.msg];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


#pragma mark - ETShopChooseCoinViewDelegate
- (void)ETShopChooseCoinViewDelegateWithCell:(NSInteger)index{
    //    if (self.type == 0) {
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
    //    }else if (self.type == 1){
    //
    //        [self getrongyunDelmygroups];
    //    }else if (self.type == 2){
    //
    //        [self getrongyunDelgropuserForuser];
    //    }
    
    
}
#pragma mark - ETNewChatDelGroupViewDelegate
- (void)ETNewChatDelGroupViewDelegateSure{
    if (self.type == 1){
        
        [self getrongyunDelmygroups];
    }else if (self.type == 2){
        
        [self getrongyunDelgropuserForuser];
    }
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ETNewChatGroupDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ETNewChatGroupDetailsCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ETNewChatGroupDetailsDataModel *model = self.dataSource[indexPath.row];
    ///加群员
    if ([model.photo isEqualToString: @"lt_tjyqhy"]) {
        ETNewChatCreateGroupViewController *vc = [ETNewChatCreateGroupViewController new];
        vc.type = 1;
        vc.tid = self.tid;
        [self.navigationController pushViewController:vc animated:true];
        
        ///移除群员
    }else if ([model.photo isEqualToString: @"lt_scqy"]) {
        ETNewChatCreateGroupViewController *vc = [ETNewChatCreateGroupViewController new];
        vc.type = 2;
        vc.tid = self.tid;
        [self.navigationController pushViewController:vc animated:true];
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

- (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
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
