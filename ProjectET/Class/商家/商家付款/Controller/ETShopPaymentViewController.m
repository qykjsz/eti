//
//  ETShopPaymentViewController.m
//  ProjectET
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETShopPaymentViewController.h"
#import "ETShopChooseModel.h"
#import "ETVerifyPassWrodView.h"
#import "ETShopChooseCoinView.h"

@interface ETShopPaymentViewController ()<ETShopChooseCoinViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)ETShopChooseCoinView *chooseView;
@property (weak, nonatomic) IBOutlet UIButton *btn_set1;
@property (weak, nonatomic) IBOutlet UIButton *btn_set2;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_moneyName;
@property (weak, nonatomic) IBOutlet UITextField *tf_money;
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lab_coinNum;
@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong)ETShopChooseModel *model;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *dataSource2;
@property (nonatomic,assign) BOOL flag;
@property (nonatomic,strong) NSString *mrate;
@property (nonatomic,strong) NSString *crate;
@property (nonatomic,strong) NSString *coinName;
@property (nonatomic,strong) NSString *coinNum;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) BOOL isPay;
@end

@implementation ETShopPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款金额";
    self.dic = [Tools dictionaryWithJsonString:self.jsonStr];
    self.dataSource = [NSMutableArray array];
    self.dataSource2 = [NSMutableArray array];
    self.chooseView.delegate = self;
    self.lab_name.text = [NSString stringWithFormat:@"%@",self.dic[@"address"]];
    [self.lab_name setLineBreakMode:NSLineBreakByTruncatingMiddle];
    if (self.dic.count != 1) {
        self.isPay = true;
        [self.btn_set1 setHidden:true];
        [self.btn_set2 setHidden:true];
        self.tf_money.text = self.dic[@"price"];
        self.lab_moneyName.text = self.dic[@"priceName"];
        [self.img_icon sd_setImageWithURL:[NSURL URLWithString:self.dic[@"img"]]];
//        self.lab_coinNum.text = [NSString stringWithFormat: @"%@ %@",self.dic[@"amount"],self.dic[@"coinName"]];
        [self.tf_money setEnabled:false];
        self.coinName = self.dic[@"coinName"];
//        self.coinNum = self.dic[@"amount"];
        [self getEtmoney:NO];
        [self getFimoney:NO];
    }else {
        self.isPay = false;
        self.flag = YES;
        self.index = 0;
        [self getEtmoney:NO];
        [self getFimoney:NO];
    }
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
            if (self.isPay) {
                for (ETShopChooseDataModel *model in self.dataSource2) {
                    if (model.name == self.dic[@"priceName"]) {
                        self.mrate = model.rate;
                    }
                }
                
                [self textFieldValueChanged:self.tf_money];
            }else {
                ETShopChooseDataModel *model = self.dataSource2[0];
                self.lab_moneyName.text = model.name;
                self.mrate = model.rate;
            }
            
        }else{
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            for (ETShopChooseDataModel *model in self.dataSource2) {
                NSDictionary *dic = @{@"img":model.img,@"name":model.name};
                [arr addObject:dic];
            }
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
            if (self.isPay) {
                for (ETShopChooseDataModel *model in self.dataSource) {
                    if (model.name ==self.dic[@"coinName"]) {
                        self.crate = model.rate;
                    }
                }
                [self textFieldValueChanged:self.tf_money];
            }else {
                     ETShopChooseDataModel *model = self.dataSource[0];
                       [self.img_icon sd_setImageWithURL:[NSURL URLWithString:model.img]];
                       self.crate = model.rate;
                       self.lab_coinNum.text = [NSString stringWithFormat:@"≈ 0.00%@",model.name];
                       self.coinName = model.name;
            }
       
        }else {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            for (ETShopChooseDataModel *model in self.dataSource) {
                NSDictionary *dic = @{@"img":model.img,@"name":model.name};
                [arr addObject:dic];
            }
            [self.chooseView reloadChooseView:arr];
            [self.chooseView show];
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}


- (void)getShop:(NSString *)hash{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"api_shop" parameters:@{@"from":model.address,
                                                                  @"to":self.dic[@"address"],
                                                                  @"hash":hash,
                                                                  @"money":self.tf_money.text,
                                                                  @"moneyid":self.lab_moneyName.text,
                                                                  @"fimoney":self.coinNum,
                                                                  @"fimoneyid":self.coinName
    } type:kPOST success:^(id responseObject) {
        [self.navigationController popViewControllerAnimated:true];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
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
        return;
    }
    
    
    if ([self.tf_money.text floatValue] <= 0) {
        [KMPProgressHUD showText:@"设置金额不能为零"];
        return ;
    }
    
    ETVerifyPassWrodView *view = [[ETVerifyPassWrodView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [view setSuccess:^{
        [self transferSure];
    }];
    [view setFailure:^{
        [KMPProgressHUD showText:@"密码错误"];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}


- (void)ETShopChooseCoinViewDelegateWithCell:(NSInteger)index{
    self.index = index;
    [self.view endEditing:YES];
    if (self.flag) {
        ETShopChooseDataModel *model = self.dataSource2[index];
        self.lab_moneyName.text = model.name;
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
    self.coinNum = [NSString stringWithFormat: @"%.4f",num / [self.crate floatValue]];
}


- (IBAction)textFieldValueChanged:(UITextField *)sender {
    CGFloat num = [self.tf_money.text floatValue] * [self.mrate floatValue];
    self.lab_coinNum.text = [NSString stringWithFormat:@"≈ %@ %@",[self notRounding:(num / [self.crate floatValue]) afterPoint:4],self.coinName];
    self.coinNum = [NSString stringWithFormat: @"%.4f",num / [self.crate floatValue]];
    if (sender.text.length > 15) {
        　　　　　　　　UITextRange *markedRange = [sender markedTextRange];
        　　　if (markedRange) {
            　　 return;
            　　　 }
        
        NSRange range = [sender.text rangeOfComposedCharacterSequenceAtIndex:15];
        sender.text = [sender.text substringToIndex:range.location];
    }
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

- (ETShopChooseCoinView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[ETShopChooseCoinView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    
    return _chooseView;
}

- (void)transferSure{
    NSString *token = @"";
    NSString *gasprice = @"";
    NSString *gaslimit = @"";
    NSString *decimal = @"";
    if (self.dic[@"price"] == nil) {
        ETShopChooseDataModel *model = self.dataSource[self.index];
        token = model.address;
        gasprice = model.gasprice;
        gaslimit = model.gaslimit;
        decimal = model.decimal;
        if ([self.coinName isEqualToString:@"ETH"]) {
            token = nil;
        }else {
            token = model.address;
        }
    }else {
        token = self.dic[@"token"];
        gasprice = self.dic[@"gasprice"];
        gaslimit = self.dic[@"gaslimit"];
        decimal = self.dic[@"decimal"];
        if ([self.coinName isEqualToString:@"ETH"]) {
            token = nil;
        }else {
            token = self.dic[@"token"];
        }
        
    }
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"et_node" parameters:nil type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        NSString *urlString = responseObject[@"data"];
        NSLog(@"%@",urlString);
        ETWalletModel *model = [ETWalletManger getCurrentWallet];
        [SVProgressHUD showWithStatus:@"正在支付"];
        [HSEther hs_sendToAssress:self.dic[@"address"] ip:urlString money:self.coinNum tokenETH:token decimal:decimal currentKeyStore:model.keyStore pwd:model.password gasPrice:gasprice gasLimit:gaslimit block:^(NSString *hashStr, BOOL suc, HSWalletError error) {
            [SVProgressHUD dismiss];
            if (suc) {
                [KMPProgressHUD showText:@"支付成功"];
                [self getShop:hashStr];
            }else {
                [KMPProgressHUD showText:@"支付失败"];
            }
        }];
    } failure:^(NSError *error) {
        [KMPProgressHUD dismissProgress];
        self.view.userInteractionEnabled = YES;
    }];
    
}



-(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
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
