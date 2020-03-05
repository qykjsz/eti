//
//  ETNewChatAddFriendViewController.m
//  ProjectET
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 LightCould. All rights reserved.
//

#import "ETNewChatAddFriendViewController.h"
#import "ETNewChatFriendViewController.h"

@interface ETNewChatAddFriendViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img_img;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_ID;
@property (nonatomic, strong) NSString *ID;

@end

@implementation ETNewChatAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加好友";
    self.ID = @"";
    [self getChatSelusername];
    // Do any additional setup after loading the view from its nib.
}

///搜索好友
- (void)getChatSelusername{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"rongyun_getuser_id" parameters:@{@"id":self.address} type:kPOST success:^(id responseObject) {
         KMP_DOTNETModel *baseModel = [KMP_DOTNETModel mj_objectWithKeyValues:responseObject];
        if (baseModel.code == 200) {
            self.ID =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"id"]];
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

///添加到通讯录
- (IBAction)actionOfAddFriend:(UIButton *)sender {
    
    ETNewChatFriendViewController *vc =[ETNewChatFriendViewController new];
    vc.ID = self.ID;
    vc.name = self.lab_name.text;
    [self.navigationController pushViewController:vc animated:true];
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
