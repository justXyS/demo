//
//  MallDetailViewController.m
//  E小区
//
//  Created by apple on 15/2/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MallDetailViewController.h"
#import "BuyService.h"
#import "Goods.h"
#import "ViewStyle.h"
#import "PanButton.h"
#import "CartViewController.h"

@interface MallDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *good_img;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *wuliuLabel;
@property (nonatomic,strong) BuyService *service;
@property (nonatomic,strong) Goods *good;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnX;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet PanButton *cart;
@property (nonatomic,assign) CGPoint center;
@end

@implementation MallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.gid) {
        [self.service getGoodDetailByGid:self.gid complementHandler:^(Goods *good) {
            self.good = good;
            [self loadData];
        }];
    }
    CGPoint center = [self.cart resetLocation];
    if (!(center.x == 0 && center.y ==0)) {
        self.btnX.constant = center.x - self.cart.bounds.size.width/2;
        self.btnY.constant = center.y - 64 - self.cart.bounds.size.height/2;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.good) {
        [self loadData];
    }
}

-(void)loadData{
    self.title = self.good.name;
    NSString *price = [NSString stringWithFormat:@"原价：%@ 元/%@",self.good.price,self.good.unit];
    self.priceLable.attributedText = [ViewStyle addAttributeWithString:price rang:[price rangeOfString:self.good.price] color:[UIColor darkGrayColor]];
    NSString *discount = [NSString stringWithFormat:@"会员价：%@ 元/%@",self.good.discount,self.good.unit];
    self.discountLabel.attributedText = [ViewStyle addAttributeWithString:discount rang:[discount rangeOfString:self.good.discount] color:[UIColor redColor]];
    self.number.text = self.good.unit_num;
    NSString *wuliu = [NSString stringWithFormat:@"温馨提示：%@",self.good.logistics];
    self.wuliuLabel.attributedText = [ViewStyle addAttributeWithString:wuliu rang:[wuliu rangeOfString:self.good.logistics] color:[UIColor grayColor]];
    [self.good_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,self.good.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
}

- (IBAction)jian:(UIButton *)sender {
    NSInteger number = [self.number.text integerValue];
    if (number>[self.good.unit_num integerValue]) {
        number --;
    }
    self.number.text = [NSString stringWithFormat:@"%lu",number];
}

- (IBAction)jia:(UIButton *)sender {
    NSInteger number = [self.number.text integerValue];
    if (number<100) {
        number ++;
    }
    self.number.text = [NSString stringWithFormat:@"%lu",number];
}

- (IBAction)buy:(UIButton *)sender {
    [self.service removeAndMoveGoodFromShopCartBuyGid:self.good.gid num:self.number.text complementHandler:^(NSString *info) {
        if ([SUCCESS isEqualToString:info]) {
            CartViewController *cvtr = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"cartViewController"];
            [self.navigationController pushViewController:cvtr animated:YES];
        }
    }];
}

- (IBAction)joinBuyCard:(UIButton *)sender {
    if (self.good) {
        [UIView animateWithDuration:.8 animations:^{
            self.scrollView.transform = CGAffineTransformMakeScale(.05, .05);
        }];
        [UIView animateWithDuration:.8 delay:.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.center = self.scrollView.center;
            self.scrollView.center = self.cart.center;
        } completion:^(BOOL finished) {
            if (finished) {
                self.scrollView.transform = CGAffineTransformIdentity;
                self.scrollView.center = self.center;
            }
        }];
        [self.service removeAndMoveGoodFromShopCartBuyGid:self.good.gid num:self.number.text complementHandler:^(NSString *info) {
            if ([SUCCESS isEqualToString:info]) {
                
            }
        }];
    }
}

- (IBAction)toShoppingCart:(PanButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
