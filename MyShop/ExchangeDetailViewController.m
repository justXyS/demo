
//
//  ExchangeDetailViewController.m
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ExchangeDetailViewController.h"
#import "ExChangeModel.h"
#import "ExchangeService.h"

@interface ExchangeDetailViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *wuliu;
@property (assign,nonatomic) NSInteger numbers;
@property (strong,nonatomic) ExchangeService *service;
@end

@implementation ExchangeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reset];
}

- (IBAction)numberLess:(UIButton *)sender{
    self.numbers --;
}

- (IBAction)numberAdd:(UIButton *)sender{
    self.numbers ++;
}

- (IBAction)exchange:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入密码" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"兑换", nil];
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    UITextField *input = (UITextField *)[alert textFieldAtIndex:0];
    input.placeholder = @"请输入支付密码";
    [alert show];
}

-(void)setExchangeModel:(ExChangeModel *)exchangeModel{
    _exchangeModel = exchangeModel;
    if (self.view.window) {
        [self reset];
    }
}

-(void)reset{
    if (self.exchangeModel) {
        [self.good_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.exchangeModel.bigpicture]] placeholderImage:[UIImage imageNamed:@"e"]];
        self.name.text = self.exchangeModel.name;
        NSString *string = [NSString stringWithFormat:@"会员价：%@E币/%@",self.exchangeModel.point,self.exchangeModel.unit];
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:string];
        [price addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[string rangeOfString:[NSString stringWithFormat:@"%@E币/%@",self.exchangeModel.point,self.exchangeModel.unit]]];
        self.price.attributedText = price;
        self.wuliu.text = [NSString stringWithFormat:@"温馨提示：%@",self.exchangeModel.logistics];
        self.numbers = 1;
    }
}

-(void)setNumbers:(NSInteger)numbers{
    if (numbers>0 && numbers<101) {
        _numbers = numbers;
        self.number.text = [NSString stringWithFormat:@"%lu",self.numbers];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *password = [alertView textFieldAtIndex:0].text;
        if (!password || password.length<6){
            [SVProgressHUD showErrorWithStatus:@"请输入6位以上密码"];
            return;
        }
        [self.service exchangeBuyGid:self.exchangeModel.gid goods_num:self.number.text paypassword:password complementHandler:^ {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

-(ExchangeService *)service{
    if (!_service) {
        _service = [[ExchangeService alloc] init];
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
