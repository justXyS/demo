//
//  CartViewController.m
//  E小区
//
//  Created by apple on 15/2/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CartViewController.h"
#import "CartCell.h"
#import "CartGood.h"
#import "BuyService.h"
#import "MyMD5.h"

@interface CartViewController ()<UITableViewDataSource,UITableViewDelegate,CartCellDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalsLabel;
@property (nonatomic,strong) BuyService *service;
@property (nonatomic,strong) NSArray *goods;
@property (nonatomic,assign) BOOL isCheckAll;
@property (nonatomic,assign) CGFloat totalPrice;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.service getCartGood:^(NSArray *goods) {
        self.goods = goods;
        [self.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goods.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cart_cell" forIndexPath:indexPath];
    CartGood *good = self.goods[indexPath.row];
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,good.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.titleLabel.text = good.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"优惠价：%@元/%@",good.discount,good.unit];
    cell.numberLabel.text = good.num;
    cell.zhekou.text = [NSString  stringWithFormat:@"%.1f折",[good.discount floatValue]/[good.price floatValue]*10];
    cell.totalPrice = [good.discount floatValue] * [good.num floatValue];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)checkAll:(UIButton *)sender {
    if (self.isCheckAll) {
        for (int i =0; i<self.goods.count; i++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            CartCell *cell = (CartCell *)[self.tableView cellForRowAtIndexPath:indexpath];
            [cell.checkButton  setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
            cell.isCheck = NO;
        }
        self.totalPrice = 0;
        [sender setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
    }else{
        CGFloat total =0;
        for (int i =0; i<self.goods.count; i++) {
            CartGood *good = self.goods[i];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            CartCell *cell = (CartCell *)[self.tableView cellForRowAtIndexPath:indexpath];
            [cell.checkButton  setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
            if (!cell.isCheck) {
                cell.isCheck = YES;
            }
             total += [good.discount floatValue] * [good.num floatValue];
        }
        self.totalPrice = total;
        [sender setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
    }
    self.isCheckAll = !self.isCheckAll;
}

- (IBAction)pay:(id)sender {
    if (self.totalPrice) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"下单", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        alert.delegate = self;
        [alert show];
    }
}

-(void)jiaCell:(CartCell *)cell btn:(UIButton *)sender{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    CartGood *good = self.goods[index.row];
    NSInteger num = [cell.numberLabel.text integerValue];
    BOOL keyi = num<100;
    if (keyi) {
        good.num = [NSString stringWithFormat:@"%lu",++num];
        cell.numberLabel.text = good.num;
        cell.totalPrice = [good.discount floatValue] * [good.num floatValue];
    }
    if (!cell.isCheck) {
        [cell.checkButton setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
        self.totalPrice += cell.totalPrice;
        cell.isCheck = YES;
    }else{
        if (keyi) {
            self.totalPrice += [good.discount floatValue];
        }
    }
}

-(void)jianCell:(CartCell *)cell btn:(UIButton *)sender{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    CartGood *good = self.goods[index.row];
    NSInteger num = [cell.numberLabel.text integerValue];
    BOOL keyi = num>[good.unit_num integerValue];
    if (keyi) {
        good.num = [NSString stringWithFormat:@"%lu",--num];
        cell.numberLabel.text = good.num;
        cell.totalPrice = [good.discount floatValue] * [good.num floatValue];
    }
    if (!cell.isCheck) {
        [cell.checkButton setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
        self.totalPrice += cell.totalPrice;
        cell.isCheck = YES;
    }else{
        if (keyi) {
            self.totalPrice -= [good.discount floatValue];
        }
    }
}

-(void)checkCell:(CartCell *)cell btn:(UIButton *)sender{
    if (cell.isCheck) {
        [sender setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
        self.totalPrice -= cell.totalPrice;
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
        self.totalPrice += cell.totalPrice;
    }
    cell.isCheck = !cell.isCheck;
}

-(void)deleteCell:(CartCell *)cell{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    CartGood *good = self.goods[index.row];
    [self.service removeAndMoveGoodFromShopCartBuyGid:good.gid num:[NSString stringWithFormat:@"-%@",good.num] complementHandler:^(NSString *info) {
        if ([SUCCESS isEqualToString:info]) {
            NSMutableArray *goods = [NSMutableArray arrayWithArray:self.goods];
            [goods removeObject:good];
            if (cell.isCheck) {
                self.totalPrice -= cell.totalPrice;
            }
            self.goods = [goods copy];
            [self.tableView reloadData];
        }
    }];
}

-(void)setTotalPrice:(CGFloat)totalPrice{
    _totalPrice = totalPrice;
    self.totalsLabel.text = [NSString stringWithFormat:@"需支付：￥%.2f",self.totalPrice];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *password = [alertView textFieldAtIndex:0].text;
        NSMutableString *matubelinfo = [[NSMutableString alloc] init];
        NSMutableArray *goods = [NSMutableArray  arrayWithArray:self.goods];
        for (int i =0; i<self.goods.count; i++) {
            CartGood *good = self.goods[i];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            CartCell *cell = (CartCell *)[self.tableView cellForRowAtIndexPath:indexpath];
            if (cell.isCheck) {
                [matubelinfo appendString:[NSString stringWithFormat:@"%@:%@,",good.gid,good.num]];
                [goods removeObject:good];
            }
        }
        NSString *info = [matubelinfo substringToIndex:matubelinfo.length];
        [self.service buyByInfo:info paypassword:[MyMD5 md5:password] paymenttype:@"1" complementHandler:^(NSString *info) {
            if ([SUCCESS isEqualToString:info]) {
                self.goods = goods;
                [self.tableView reloadData];
            }
        }];
    }
}

-(BuyService *)service{
    if (!_service) {
        _service = [[BuyService alloc] init];
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
