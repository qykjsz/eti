//
//  ETNewChatAddressFriendMsgViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatAddressFriendMsgViewController.h"
#import "ETNewChatAddressFriendSetViewController.h"
#import "ETNewChatDetailsViewController.h"

@interface ETNewChatAddressFriendMsgViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_ID;
@property (weak, nonatomic) IBOutlet UILabel *lab_note;

@end

@implementation ETNewChatAddressFriendMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getChatSelusername];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setImage:[UIImage imageNamed:@"…"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.lab_note.text = [NSString stringWithFormat:@"备注:%@",self.remarks];
    // Do any additional setup after loading the view from its nib.
}

///搜索好友
- (void)getChatSelusername{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_getuser_id" parameters:@{@"id":self.uid} type:kPOST success:^(id responseObject) {
        KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.lab_ID.text = [NSString stringWithFormat:@"ID:%@",responseObject[@"data"][@"id"]];
            self.lab_name.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"name"]];
            
            [self.img_img sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"photo"]]]];
            
        }else{
            [KMPProgressHUD showText:baseModel.msg];
            //            [self.navigationController popViewControllerAnimated:true];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}

- (void)rightBtnAction{
    ETNewChatAddressFriendSetViewController *vc = [ETNewChatAddressFriendSetViewController new];
    vc.uid = self.uid;
    [self.navigationController pushViewController:vc animated:true];
}


///发消息
- (IBAction)actionOfSend:(UIButton *)sender {
     ETNewChatDetailsViewController *conversationVC = [[ETNewChatDetailsViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:self.uid];
        conversationVC.title = @"聊天";
    conversationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:conversationVC animated:true];
    
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
