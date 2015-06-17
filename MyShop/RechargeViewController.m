//
//  RechargeViewController.m
//  E小区
//
//  Created by apple on 15/2/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeCell.h"
#import "TransactionService.h"

#define ACCOUNT_MAX_CHARS 5

@interface RechargeViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSInteger checkIndex;
@property (nonatomic,strong) NSArray *recharges;
@property (nonatomic,strong) TransactionService *service;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            self.moneyLabel.text = @"50";
            break;
        case 2:
            self.moneyLabel.text = @"100";
            break;
        case 3:
            self.moneyLabel.text = @"200";
            break;
        case 4:
            self.moneyLabel.text = @"500";
            break;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.moneyLabel resignFirstResponder];
}

- (IBAction)recharge:(id)sender {
    switch (self.checkIndex) {
        case 0:
            {
                NSString *price = self.moneyLabel.text;
                if (!price || [price containsString:@"."] || price.length<1) return;
                [self.service payOrderIdBy:price pay_mode:@"PAY_BAO" complement:^(PayOrderModel *payOrder) {
                    NSString *appScheme = @"Club";
                    //NSString* orderInfo = [self getOrderInfoWithCreate_pay_orderInfo:model andPrice:self.price.text];
                    //NSString* signedStr = [self doRsa:orderInfo andPrivateKey:model.private];
                    //NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                             //orderInfo, signedStr, @"RSA"];
                }];
            }
            
            
//            [service create_orderWithToken:user.token andUserType:user.user_type andPrice:self.price.text andPayModel:@"PAY_BAO" inTabBarController:self.tabBarController withDone:^(Create_pay_orderInfo *model){
//                NSString *appScheme = @"Club";
//                NSString* orderInfo = [self getOrderInfoWithCreate_pay_orderInfo:model andPrice:self.price.text];
//                NSString* signedStr = [self doRsa:orderInfo andPrivateKey:model.private];
//                NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                                         orderInfo, signedStr, @"RSA"];
//                sharedData.createPayPrice = [self.price.text floatValue];
//                NSLog(@"sharedData.createPayPrice:%f",sharedData.createPayPrice);
//                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                    //            NSLog(@"reslut = %@",resultDic);
//                    //            NSString *status = [resultDic objectForKey:@"resultStatus"];
//                    //            if ([status isEqualToString:@"9000"]) {
//                    //                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
//                    //                user.amount = user.amount+[self.price.text floatValue];
//                    //                [service pushToMyWalletViewControllerInTabBarController:self.tabBarController];
//                    ////                [service reloadAmoutAfterPopToViewControllerInNav:self.navigationController];
//                    //            }else{
//                    //                [SVProgressHUD showErrorWithStatus:@"支付失败"];
//                    //            }
//                }];
//            }];
            break;
            
        default:
            break;
    }
}

-(NSString*)getOrderInfoWithCreate_pay_orderInfo:(RechargeModel *)model andPrice:(NSString *)price
{
//    SharedData *sharedData = [SharedData sharedInstance];
//    UserInfo *user = sharedData.user;
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    RechargeModel *order = [[RechargeModel alloc] init];
//    order.partner = model.default_partner;
//    order.seller = model.default_seller;
//    order.tradeNO = model.out_trade_no; //订单ID（由商家自行制定）
//    order.productName = [NSString stringWithFormat:@"%@在线充值",user.nickname]; //商品标题
//    order.productDescription = @"E小区充值"; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",[price floatValue]]; //商品价格
//    order.notifyURL = model.notify_url; //回调URL
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
    return [order description];
}

//-(NSString*)doRsa:(NSString*)orderInfo andPrivateKey:(NSString *)privateKey
//{
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    //NSString *signedString = [signer signString:orderInfo];
//    return signedString;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rechargeCell" forIndexPath:indexPath];
    cell.rechargeModel = self.recharges[indexPath.row];
//    __weak RechargeCell *weakCell = cell;
//    cell.action = ^{
//        self.checkIndex = indexPath.row;
//        [self check:weakCell];
//    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == self.checkIndex) {
        cell.isCheck = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.checkIndex != indexPath.row) {
        self.checkIndex = indexPath.row;
        for (int i=0;i<self.recharges.count;i++) {
            RechargeCell *cell = (RechargeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (self.checkIndex != i) {
                cell.isCheck = NO;
            }else{
                cell.isCheck = YES;
            }
        }
    }
}


-(void)setCheckIndex:(NSInteger)checkIndex{
    _checkIndex = checkIndex;
}

-(NSArray *)recharges{
    if (!_recharges) {
        RechargeModel *recharge1 = [[RechargeModel alloc] init];
        recharge1.payName = @"支付宝";
        recharge1.payPrompt = @"推荐有支付宝账号的用户使用";
        recharge1.path = @"zhifubao";
        RechargeModel *recharge2 = [[RechargeModel alloc] init];
        recharge2.payName = @"银联支付";
        recharge2.payPrompt = @"支持信用卡和储蓄卡,无需开通网银";
        recharge2.path = @"bank";
        RechargeModel *recharge3 = [[RechargeModel alloc] init];
        recharge3.payName = @"微信支付";
        recharge3.payPrompt = @"推荐安装微信5.0及以上版本使用";
        recharge3.path = @"weixin";
        _recharges = @[recharge1,recharge2,recharge3];
    }
    return _recharges;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger length = textField.text.length;
    if (length >= ACCOUNT_MAX_CHARS && string.length >0) return NO;
//    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    BOOL basic = [string isEqualToString:filtered];
    NSLog(@"ddd");
    return YES;
}

-(TransactionService *)service{
    if (!_service) {
        _service = [[TransactionService alloc] init];
    }
    return _service;
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
