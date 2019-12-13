//
//  ETShopSetMoneyViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETShopSetMoneyViewController.h"
#import "ETShopChooseCoinView.h"
#import "ETVerifyPassWrodView.h"

#import "ETShopChooseModel.h"
@interface ETShopSetMoneyViewController ()<ETShopChooseCoinViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)ETShopChooseCoinView *chooseView;
@property (weak, nonatomic) IBOutlet UILabel *lab_moneyName;
@property (weak, nonatomic) IBOutlet UITextField *tf_money;
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lab_coinNum;
@property (nonatomic,strong)ETShopChooseModel *model;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *dataSource2;
@property (nonatomic,assign) BOOL flag;
@property (nonatomic,strong) NSString *mrate;
@property (nonatomic,strong) NSString *crate;
@property (nonatomic,strong) NSString *coinName;
@property (nonatomic,strong) NSString *coinNum;
@property (nonatomic,strong) NSString *moneyName;
@property (nonatomic,assign) NSInteger index;
@end

@implementation ETShopSetMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置金额";
    self.dataSource = [NSMutableArray array];
    self.dataSource2 = [NSMutableArray array];
    self.chooseView.delegate = self;
    self.flag = YES;
    self.index = 0;
    [self getEtmoney:NO];
    [self getFimoney:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)getEtmoney:(BOOL)flag{
     [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"give_et_money" parameters:@{@"":@""} type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.dataSource2 removeAllObjects];
        self.model =[ETShopChooseModel mj_objectWithKeyValues:responseObject];
        [self.dataSource2 addObjectsFromArray:self.model.data];
        if (!flag) {
            ETShopChooseDataModel *model = self.dataSource2[0];
            self.lab_moneyName.text = model.name;
            self.moneyName = model.name;
            self.mrate = model.rate;
        }else{
            NSMutableArray *arr = [[NSMutableArray alloc]init];
                   for (ETShopChooseDataModel *model in self.dataSource2) {
                       NSDictionary *dic = @{@"img":model.img,@"name":model.name};
                       [arr addObject:dic];
                   }
            self.chooseView.lab_title.text = @"选择货币";
                   [self.chooseView reloadChooseView:arr];
                   [self.chooseView show];
        }
       
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

- (void)getFimoney:(BOOL)flag{
     [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"give_et_fimoney" parameters:@{@"":@""} type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.dataSource removeAllObjects];
        self.model =[ETShopChooseModel mj_objectWithKeyValues:responseObject];
        [self.dataSource addObjectsFromArray:self.model.data];
        if (!flag) {
            ETShopChooseDataModel *model = self.dataSource[0];
            [self.img_icon sd_setImageWithURL:[NSURL URLWithString:model.img]];
            self.crate = model.rate;
            self.lab_coinNum.text = [NSString stringWithFormat:@"≈ 0.00%@",model.name];
            self.coinName = model.name;
        }else {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            for (ETShopChooseDataModel *model in self.dataSource) {
                NSDictionary *dic = @{@"img":model.img,@"name":model.name};
                [arr addObject:dic];
            }
            self.chooseView.lab_title.text = @"选择币种";
            [self.chooseView reloadChooseView:arr];
            [self.chooseView show];
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}



- (ETShopChooseCoinView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[ETShopChooseCoinView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    
    return _chooseView;
}

///选择货币
- (IBAction)actionOfChooseMoney:(UIButton *)sender {
    [self.view endEditing:YES];
    [self getEtmoney:YES];
    self.flag = YES;
}

///选择虚拟币
- (IBAction)actionOfChooseCoin:(UIButton *)sender {
    [self.view endEditing:YES];
    [self getFimoney:YES];
    self.flag = NO;
}

///确定
- (IBAction)actionOfSure:(UIButton *)sender {
    [self.view endEditing:true];
    if (self.tf_money.text.length == 0) {
        [KMPProgressHUD showText:@"请输入金额"];
        return ;
    }
    
    if ([self.tf_money.text floatValue] <= 0) {
           [KMPProgressHUD showText:@"设置金额不能为零"];
           return ;
    }
    
    ETShopChooseDataModel *model = self.dataSource[self.index];
    ETWalletModel *model3 = [ETWalletManger getCurrentWallet];
    NSString *token = @"";
    if (![self.coinName isEqualToString:@"ETH"]) {
        token = model.address;
    }
    NSDictionary *dic = @{@"price":self.tf_money.text,
                          @"priceName" : self.moneyName,
                          @"amount" : self.coinNum,
                          @"img" : model.img,
                          @"token":token,
                          @"decimal":model.decimal,
                          @"gaslimit":model.gaslimit,
                          @"gasprice":model.gasprice,
                          @"coinName":self.coinName,
                          @"address":model3.address};
    
    if ([self.delegate respondsToSelector:@selector(ETShopSetMoneyViewControllerDelegateWithCell:)]) {
            [self.delegate ETShopSetMoneyViewControllerDelegateWithCell:[Tools dataTojsonString:dic]];
        [self.navigationController popViewControllerAnimated:true];
        }
    
//    ETVerifyPassWrodView *view = [[ETVerifyPassWrodView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [view setSuccess:^{
//        [self transferSure];
//    }];
//    [view setFailure:^{
//        [KMPProgressHUD showText:@"密码错误"];
//    }];
//    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    
}

- (void)ETShopChooseCoinViewDelegateWithCell:(NSInteger)index{
    self.index = index;
    [self.view endEditing:YES];
    if (self.flag) {
        ETShopChooseDataModel *model = self.dataSource2[index];
        self.lab_moneyName.text = model.name;
        self.moneyName = model.name;
        self.mrate = model.rate;
    }else {
        ETShopChooseDataModel *model = self.dataSource[index];
        [self.img_icon sd_setImageWithURL:[NSURL URLWithString:model.img]];
        self.lab_coinNum.text = [NSString stringWithFormat:@"≈ 0.00%@",model.name];
        self.crate = model.rate;
        self.coinName = model.name;
    }
    
        CGFloat num = [self.tf_money.text floatValue] * [self.mrate floatValue];
        self.lab_coinNum.text = [NSString stringWithFormat:@"≈ %@ %@",[self notRounding:(num / [self.crate floatValue]) afterPoint:4],self.coinName];
       self.coinNum = [NSString stringWithFormat:@"%@",[self notRounding:(num / [self.crate floatValue]) afterPoint:4]];
}

- (IBAction)textFieldValueChanged:(UITextField *)sender {
    CGFloat num = [self.tf_money.text floatValue] * [self.mrate floatValue];
      self.lab_coinNum.text = [NSString stringWithFormat:@"≈ %@ %@",[self notRounding:(num / [self.crate floatValue]) afterPoint:4],self.coinName];
     self.coinNum = [NSString stringWithFormat:@"%@",[self notRounding:(num / [self.crate floatValue]) afterPoint:4]];
    if (sender.text.length > 15) {
    　　　　　　　　UITextRange *markedRange = [sender markedTextRange];
            　　　if (markedRange) {
               　　 return;
           　　　 }
    
    NSRange range = [sender.text rangeOfComposedCharacterSequenceAtIndex:15];
                   sender.text = [sender.text substringToIndex:range.location];
    }
}


///想下取整
-(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;

    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //        //第一个参数，被替换字符串的range，第二个参数，即将键入或者粘贴的string，返回的是改变过后的新str，即textfield的新的文本内容
    
    NSString *oldText = textField.text;
    NSString *checkStr = [oldText stringByReplacingCharactersInRange:range withString:string];
    if (checkStr.length == 0) {
        return YES;
    }
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isValid = [predicte evaluateWithObject:checkStr];
    return isValid;
}

//- (void)transferSure{
//    ETShopChooseDataModel *model = self.dataSource[self.index];
//    NSString *token = @"";
//    NSString *gasprice = model.gasprice;
//    NSString *gaslimit = model.gaslimit;
//    NSString *decimal = model.decimal;
//    if ([self.coinName isEqualToString:@"ETH"]) {
//        token = nil;
//    }else {
//        token = model.address;
//    }
//
//     [SVProgressHUD showWithStatus:@"正在支付"];
//       [HTTPTool requestDotNetWithURLString:@"et_node" parameters:nil type:kPOST success:^(id responseObject) {
//           NSLog(@"%@",responseObject);
//           [SVProgressHUD dismiss];
//           NSString *urlString = responseObject[@"data"];
//           NSLog(@"%@",urlString);
//           ETWalletModel *model = [ETWalletManger getCurrentWallet];
//           [HSEther hs_sendToAssress:@"" ip:urlString money:self.coinNum tokenETH:token decimal:decimal currentKeyStore:model.keyStore pwd:model.password gasPrice:gasprice gasLimit:gaslimit block:^(NSString *hashStr, BOOL suc, HSWalletError error) {
//               if (suc) {
//                   [KMPProgressHUD showText:@"支付成功"];
//                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                       [self.navigationController popToRootViewControllerAnimated:YES];
//                   });
//
//               }else {
//                   [KMPProgressHUD showText:@"支付失败"];
//               }
//           }];
//       } failure:^(NSError *error) {
//           [KMPProgressHUD dismissProgress];
//           self.view.userInteractionEnabled = YES;
//       }];
//
//}
//


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
