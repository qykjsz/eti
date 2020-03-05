//
//  ETTopupCenterViewController.m
//  ProjectET
//
//  Created by mac on 2019/12/9.
//  Copyright © 2019 LightCould. All rights reserved.
//

#import "ETTopupCenterViewController.h"
#import "ETShopChooseCoinView.h"
#import "ETVerifyPassWrodView.h"
#import "ETTopupCenterRecordViewController.h"
#import "ETTopUpExplainviewController.h"
#import "ETTopUpVerifyPassWrodView.h"
#import "ETShopChooseModel.h"

@interface ETTopupCenterViewController ()<ETShopChooseCoinViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_gameName;
@property (weak, nonatomic) IBOutlet UITextField *tf_userName;
@property (weak, nonatomic) IBOutlet UITextField *tf_num;
@property (weak, nonatomic) IBOutlet UILabel *lab_coinName;
@property (weak, nonatomic) IBOutlet UIButton *btn_validation;
@property (weak, nonatomic) IBOutlet UILabel *lab_coinNum;
@property (weak, nonatomic) IBOutlet UILabel *lab_coin;
@property (weak, nonatomic) IBOutlet UIButton *btn_sel;
@property (nonatomic,strong) NSMutableArray *coinData;
@property (nonatomic,strong) NSMutableArray *gameData;
@property (nonatomic,strong) NSMutableArray *numData;
@property (nonatomic,strong) NSString *crate;
@property (nonatomic,strong) NSString *mrate;
@property (nonatomic,strong) NSString *grate;
@property (nonatomic,strong)ETShopChooseModel *model;
@property(nonatomic,strong)ETShopChooseCoinView *chooseView;
@property (nonatomic, assign)NSInteger typeIndex;
@property (nonatomic,assign) BOOL userFlag;
@property (nonatomic,strong) NSString *coinNum;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSString *gameAddress;
@property (nonatomic,strong) NSString *gameID;
@property (nonatomic,strong) NSString *gameUrl;
@end

@implementation ETTopupCenterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值中心";
    self.gameID = @"";
    self.coinData = [NSMutableArray array];
    self.gameData = [NSMutableArray array];
    self.numData = [NSMutableArray array];
    [self getEtmoney];
    [self getFimoney:NO];
    [self getETGames:NO];
    self.chooseView.delegate = self;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setImage:[UIImage imageNamed:@"czcz_icon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    
    
    // Do any additional setup after loading the view from its nib.
}

///获取人民币汇率
- (void)getEtmoney{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"give_et_money" parameters:@{@"":@""} type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.model =[ETShopChooseModel mj_objectWithKeyValues:responseObject];
        for (ETShopChooseDataModel *model in self.model.data) {
            if ([model.name isEqualToString:@"CNY"]) {
                self.mrate = model.rate;
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

///获取币种
- (void)getFimoney:(BOOL)flag{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"give_et_fimoney" parameters:@{@"gameid":self.gameID} type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.coinData removeAllObjects];
        self.model =[ETShopChooseModel mj_objectWithKeyValues:responseObject];
        [self.coinData addObjectsFromArray:self.model.data];
        if (!flag) {
            ETShopChooseDataModel *model = self.coinData[0];
            self.crate = model.rate;
            self.lab_coinNum.text = @"≈ 0.00";
            self.lab_coinName.text = model.name;
            self.lab_coin.text = model.name;
            self.index = 0;
        }else {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            for (ETShopChooseDataModel *model in self.coinData) {
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

///获取游戏平台
- (void)getETGames:(BOOL)flag{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"support_et_games" parameters:@{@"":@""} type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.gameData removeAllObjects];
        self.model =[ETShopChooseModel mj_objectWithKeyValues:responseObject];
        [self.gameData addObjectsFromArray:self.model.data];
        if (!flag) {
            ETShopChooseDataModel *model = self.gameData[0];
            self.lab_gameName.text = model.name;
            self.gameAddress = model.address;
            self.gameID = model.ID;
            self.grate = model.proportion;
            self.gameUrl = model.is_user_url;
        }else {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            for (ETShopChooseDataModel *model in self.gameData) {
                NSDictionary *dic = @{@"address":model.address,@"name":model.name,@"isUrl":model.is_user_url};
                [arr addObject:dic];
            }
            self.chooseView.lab_title.text = @"选择平台";
            [self.chooseView reloadChooseView:arr];
            [self.chooseView show];
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}


///获取平台币数量
- (void)getETGamemoneys{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"support_et_gamemoneys" parameters:@{@"":@""} type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.numData removeAllObjects];
        self.model =[ETShopChooseModel mj_objectWithKeyValues:responseObject];
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (id num in self.model.numData) {
            NSDictionary *dic = @{@"name":[NSString stringWithFormat:@"%@",num]};
            [arr addObject:dic];
            [self.numData addObject:dic];
        }
        self.chooseView.lab_title.text = @"选择数量";
        [self.chooseView reloadChooseView:arr];
        [self.chooseView show];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

///获取平台币数量
- (void)getETGamenser{
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"give_et_gamenser" parameters:@{@"gameid":self.gameID,@"gameuser":self.tf_userName.text} type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.btn_validation setTitle:@"" forState:UIControlStateNormal];
               if ([responseObject[@"code"] intValue] == 1) {
                   self.userFlag = YES;
                   [self.btn_validation setImage:[UIImage imageNamed:@"yz_cg_icon"] forState:UIControlStateNormal];
                   [KMPProgressHUD showText:responseObject[@"msg"]];
               }else {
                   self.userFlag = NO;
                   [self.btn_validation setImage:[UIImage imageNamed:@"yz_sb_icon"] forState:UIControlStateNormal];
                   [KMPProgressHUD showText:responseObject[@"msg"]];
               }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

/////验证账号
//- (void)getGameName{
//    [SVProgressHUD showWithStatus:@""];
//    [HTTPTool requestGameDotNetWithURLString: [NSString stringWithFormat:@"%@%@",self.gameUrl,self.tf_userName.text]  parameters:@{} type:kGET success:^(id responseObject) {
//        [self.btn_validation setTitle:@"" forState:UIControlStateNormal];
//        if ([responseObject[@"code"] intValue] == 1) {
//            self.userFlag = YES;
//            [self.btn_validation setImage:[UIImage imageNamed:@"yz_cg_icon"] forState:UIControlStateNormal];
//            [KMPProgressHUD showText:responseObject[@"msg"]];
//        }else {
//            self.userFlag = NO;
//            [self.btn_validation setImage:[UIImage imageNamed:@"yz_sb_icon"] forState:UIControlStateNormal];
//            [KMPProgressHUD showText:responseObject[@"msg"]];
//        }
//
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
//    }];
//}

///游戏充值
- (void)getETGame:(NSString *)hash{
    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"recharge_et_game" parameters:@{@"from":model.address,
                                                                          @"to":self.gameAddress,
                                                                          @"hash":hash,
                                                                          @"moneystate":self.lab_coinName.text,
                                                                          @"gameid":self.gameID,
                                                                          @"money":self.coinNum,
                                                                          @"gamenumber":self.tf_num.text,
                                                                          @"gameuser" : self.tf_userName.text
    } type:kPOST success:^(id responseObject) {
        [KMPProgressHUD showText:@"提交成功"];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

///验证游戏充值数据
- (void)getETGameVerification{
    //    ETWalletModel *model = [ETWalletManger getCurrentWallet];
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"recharge_et_game_verification" parameters:@{@"gameid":self.gameID,
                                                                                       @"gamenumber":self.tf_num.text,
                                                                                       @"moneystate":self.lab_coinName.text,
                                                                                       @"money":self.coinNum
    } type:kPOST success:^(id responseObject) {
        self.coinNum = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
        ETTopUpVerifyPassWrodView *view = [[ETTopUpVerifyPassWrodView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        view.lab_num.text = [NSString stringWithFormat:@"需支付：%@%@",self.coinNum,self.lab_coinName.text];
        [view setSuccess:^{
            [self transferSure];
        }];
        [view setFailure:^{
            [KMPProgressHUD showText:@"密码错误"];
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}


- (void)rightBtnAction{
    [self.navigationController pushViewController:[[ETTopUpExplainviewController alloc]init] animated:true];
}


///其他充值
- (IBAction)actionOfOtherTopup:(UIButton *)sender {
    [KMPProgressHUD showText:@"暂未开放"];
}

///充值记录
- (IBAction)actionOfTopUpRecord:(UIButton *)sender {
    ETTopupCenterRecordViewController *vc = [[ETTopupCenterRecordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}

///选择
- (IBAction)actionOfType:(UIButton *)sender {
    /// 0游戏平台 1验证账号 2选择货币 3选择币种
    [self.view endEditing:YES];
    self.typeIndex = sender.tag - 500;
    if (sender.tag - 500 == 0) {
        [self getETGames:YES];
    }else if (sender.tag - 500 == 1) {
        if (self.tf_userName.text.length == 0) {
            [KMPProgressHUD showText:self.tf_userName.placeholder];
            return;
        }
        [self getETGamenser];
    }else if (sender.tag - 500 == 2) {
        [self getETGamemoneys];
    }else if (sender.tag - 500 == 3) {
        [self getFimoney:YES];
    }
}

///协议
- (IBAction)actionOfSel:(UIButton *)sender {
    sender.selected = !sender.selected;
}

///确认支付
- (IBAction)actionOfSure:(UIButton *)sender {
    if (self.tf_userName.text.length == 0) {
        [KMPProgressHUD showText:self.tf_userName.placeholder];
        return;
    }
    
    if (!self.userFlag) {
        [KMPProgressHUD showText:@"请验证平台账号"];
        return;
    }
    
    if (self.tf_num.text.length == 0 || [self.tf_num.text floatValue] == 0.00) {
        [KMPProgressHUD showText:self.tf_num.placeholder];
        return;
    }
    
    if (!self.btn_sel.selected) {
        [KMPProgressHUD showText:@"请阅读并同意Etoken充值协议"];
        return;
    }
    
    [self getETGameVerification];
    
    
}

- (void)transferSure{
    NSString *token = @"";
    NSString *gasprice = @"";
    NSString *gaslimit = @"";
    NSString *decimal = @"";
    ETShopChooseDataModel *model  = self.coinData[self.index];
    token = model.address;
    gasprice = model.gasprice;
    gaslimit = model.gaslimit;
    decimal = model.decimal;
    if ([model.name isEqualToString:@"ETH"]) {
        token = nil;
    }else {
        token = model.address;
    }
    [SVProgressHUD showWithStatus:@""];
    [HTTPTool requestDotNetWithURLString:@"et_node" parameters:nil type:kPOST success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        NSString *urlString = responseObject[@"data"];
        NSLog(@"%@",urlString);
        ETWalletModel *model = [ETWalletManger getCurrentWallet];
        [SVProgressHUD showWithStatus:@"正在支付"];
        [HSEther hs_sendToAssress:self.gameAddress ip:urlString money:self.coinNum tokenETH:token decimal:decimal currentKeyStore:model.keyStore pwd:model.password gasPrice:gasprice gasLimit:gaslimit block:^(NSString *hashStr, BOOL suc, HSWalletError error) {
            [SVProgressHUD dismiss];
            if (suc) {
                [KMPProgressHUD showText:@"支付成功"];
                [self getETGame:hashStr];
            }else {
                [KMPProgressHUD showText:@"支付失败"];
            }
        }];
    } failure:^(NSError *error) {
        [KMPProgressHUD dismissProgress];
        self.view.userInteractionEnabled = YES;
    }];
    
}

- (void)ETShopChooseCoinViewDelegateWithCell:(NSInteger)index{
    /// 0游戏平台 1验证账号 2选择货币 3选择币种
    [self.view endEditing:YES];
    if (self.typeIndex == 0) {
        
        ETShopChooseDataModel *model = self.gameData[index];
        self.lab_gameName.text = model.name;
        self.gameAddress = model.address;
        self.gameID = model.ID;
        self.grate = model.proportion;
        self.gameUrl = model.is_user_url;
        [self textFieldDidBeginEditing:self.tf_userName];
         [self getFimoney:NO];
        self.tf_num.text = @"";
    }else if (self.typeIndex  == 1) {
        
    }else if (self.typeIndex  == 2) {
        NSDictionary *dic = self.numData[index];
        self.tf_num.text = dic[@"name"];
        [self textFieldValueChanged:self.tf_num];
    }else if (self.typeIndex  == 3) {
        ETShopChooseDataModel *model = self.coinData[index];
        self.index = index;
        self.lab_coin.text = model.name;
        self.lab_coinName.text = model.name;
        self.crate = model.rate;
        [self textFieldValueChanged:self.tf_num];
    }
}


- (IBAction)textFieldValueChanged:(UITextField *)sender {
    if (![self.gameID isEqualToString:@"8"]) {
        CGFloat num = [self.tf_num.text floatValue] * [self.mrate floatValue] * [self.grate floatValue];
        self.lab_coinNum.text = [NSString stringWithFormat:@"≈ %@",[self notRounding:(num / [self.crate floatValue]) afterPoint:4]];
        self.coinNum = [self notRounding:(num / [self.crate floatValue]) afterPoint:4];
    }else {
        self.lab_coinNum.text = self.tf_num.text;
        self.coinNum = self.tf_num.text;
    }
    
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
    if (textField == self.tf_num) {
        NSString *oldText = textField.text;
        NSString *checkStr = [oldText stringByReplacingCharactersInRange:range withString:string];
        if (checkStr.length == 0) {
            return YES;
        }
        NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
        NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        BOOL isValid = [predicte evaluateWithObject:checkStr];
        return isValid;
    }else {
        return true;
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.tf_userName) {
        self.userFlag = NO;
        [self.btn_validation setTitle:@"验证" forState:UIControlStateNormal];
        [self.btn_validation setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}


- (ETShopChooseCoinView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[ETShopChooseCoinView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    
    return _chooseView;
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
