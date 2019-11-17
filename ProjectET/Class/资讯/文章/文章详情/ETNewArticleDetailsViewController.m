//
//  ETNewArticleDetailsViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/13.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETNewArticleDetailsViewController.h"

@interface ETNewArticleDetailsViewController ()

@end

@implementation ETNewArticleDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章详情";
     [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"et_newscontent" parameters:@{@"id":self.Id} type:kPOST success:^(id responseObject) {
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.numberOfLines = 0;
        titleLb.font = [UIFont boldSystemFontOfSize:14];
        titleLb.textColor = UIColorFromHEX(0x000000, 1);
        [self.view addSubview:titleLb];
        
        WEAK_SELF(self);
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.left.top.equalTo(self.view).offset(15);
            make.right.equalTo(self.view.mas_right).offset(-15);
            
        }];
        
        
        UILabel *timeLb= [[UILabel alloc]init];
        timeLb.numberOfLines = 0;
        timeLb.font = [UIFont systemFontOfSize:11];
        timeLb.textColor = UIColorFromHEX(0x99AFD9, 1);
        [self.view addSubview:timeLb];
        
        [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.top.equalTo(titleLb.mas_bottom).offset(10);
            make.right.equalTo(self.view.mas_right).offset(-15);
            make.left.equalTo(self.view.mas_left).offset(15);
            
        }];
        
        UITextView *detailLb= [[UITextView alloc]init];
        detailLb.font = [UIFont systemFontOfSize:13];
        detailLb.textColor = UIColorFromHEX(0x666666, 1);
        detailLb.editable = NO;
        [self.view addSubview:detailLb];
        
        [detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            STRONG_SELF(self);
            make.top.equalTo(timeLb.mas_bottom).offset(15);
            make.right.equalTo(self.view.mas_right).offset(-15);
            make.left.equalTo(self.view.mas_left).offset(15);
            make.bottom.equalTo(self.view.mas_bottom);
            
        }];
        
        NSString *detailText = responseObject[@"data"][@"text"];
        NSDictionary *dic = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
        NSMutableAttributedString *mAStr = [[NSMutableAttributedString alloc] initWithData:[detailText dataUsingEncoding:NSUnicodeStringEncoding] options:dic documentAttributes:nil error:nil];
        
        titleLb.text = responseObject[@"data"][@"name"];
        timeLb.text = responseObject[@"data"][@"time"];
        detailLb.attributedText = mAStr;
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
    // Do any additional setup after loading the view from its nib.
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
