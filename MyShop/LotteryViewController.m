//
//  LotteryViewController.m
//  E小区
//
//  Created by apple on 15/2/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LotteryViewController.h"
#import "MaqueeLabel.h"

@interface LotteryViewController ()
@property (nonatomic,strong) NSArray *info;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn1;  //按顺时针方向
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn2;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn3;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn4;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn5;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn6;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn7;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn8;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn9;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn10;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn11;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn12;
@property (nonatomic,strong) NSArray *lotterybtns;
@property (nonatomic,strong) NSTimer *lotteryTimer;
@property (nonatomic,assign) BOOL lotterying;
@property (nonatomic,assign) NSInteger currLottery;
@property (nonatomic,assign) BOOL isReturn;
@property (nonatomic,assign) NSInteger resultIndex;
@property (nonatomic,assign) CGFloat velocity;
@property (weak, nonatomic) IBOutlet MaqueeLabel *lotteryInfo;
@property (nonatomic,assign) NSInteger preLotterResult;
@end

@implementation LotteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
}


-(void)initDatas{
    for (int i=0; i<self.lotterybtns.count; i++) {
        UIButton *lotteryBtn = self.lotterybtns[i];
        [lotteryBtn setTitle:self.info[i] forState:UIControlStateNormal];
    }
    self.velocity = 0.8f;
    [self.lotteryInfo setText:@"恭喜会员xy抽中5元红包恭喜会员xy抽中2元红包恭喜会员xy抽中3元红包恭喜会员xy抽中7元红包恭喜会员xy抽中8元红包恭喜会员xy抽中5元红包恭喜会员xy抽中5元红包恭喜会员xy抽中5元红包" maquee:YES];
}

- (IBAction)lottery:(id)sender {
    int time = arc4random() % 4 +2;
    if (!self.lotterying) {
        self.lotteryTimer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(beginRote:) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(result) userInfo:nil repeats:NO];
        self.lotterying = YES;
    }else{
        NSLog(@"正在抽奖..");
    }
}

-(void)beginRote:(NSTimer *)lotteryTimer{
    if (self.isReturn) {
        [self reSetLotteryStatus];
        if ((self.currLottery - self.preLotterResult - 1)/(NSInteger)self.lotterybtns.count < 3) {
            [self resetSpeed];
        }else{
            [self resetSlow];
        }
    }else{
        if (((self.currLottery - self.preLotterResult -1)/(NSInteger)self.lotterybtns.count) > 15) {
            NSInteger preTotal = self.currLottery - 1;
            if (preTotal > -1) {
                UIButton *preLotteryBtn = self.lotterybtns[preTotal%self.lotterybtns.count];
                [self lotteryBtnUnSelected:preLotteryBtn];
            }
            [SVProgressHUD showErrorWithStatus:@"网络不稳定"];
        }else{
            [self reSetLotteryStatus];
            [self resetSpeed];
        }
        
    }
}

-(void)reSetLotteryStatus{
    NSInteger total = self.currLottery;
    UIButton *lotteryBtn = self.lotterybtns[total%self.lotterybtns.count];
    [self lotteryBtnSelected:lotteryBtn];
    NSInteger preTotal = total - 1;
    if (preTotal > -1) {
        UIButton *preLotteryBtn = self.lotterybtns[preTotal%self.lotterybtns.count];
        [self lotteryBtnUnSelected:preLotteryBtn];
    }
    self.currLottery ++;
}

-(void)resetSpeed{
    if (self.currLottery%2 == 0 && self.velocity > 0.1f) {
        self.velocity -= 0.1f;
    }
    self.lotteryTimer = [NSTimer scheduledTimerWithTimeInterval:self.velocity target:self selector:@selector(beginRote:) userInfo:nil repeats:NO];
}

-(void)resetSlow{
    if ((self.currLottery -1)%self.lotterybtns.count == self.resultIndex && self.velocity == 0.8f) {
        self.currLottery --;
        UIButton *btn = self.lotterybtns[self.resultIndex];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"中了%@",[btn titleForState:UIControlStateNormal]]];
        self.lotterying = NO;
        self.isReturn = NO;
        self.velocity = 0.8f;
        self.preLotterResult = self.currLottery;
    }else{
        if (self.velocity < 0.8f) {
            self.velocity += 0.1f;
        }
        self.lotteryTimer = [NSTimer scheduledTimerWithTimeInterval:self.velocity target:self selector:@selector(beginRote:) userInfo:nil repeats:NO];
    }
}

-(void)result{
    self.isReturn = YES;
    self.resultIndex = (NSInteger)arc4random() % 12;
}

-(void)lotteryBtnSelected:(UIButton *)lotteryBtn{
    lotteryBtn.layer.borderColor = MAIN_COLOR.CGColor;
    lotteryBtn.layer.borderWidth = 3;
    //lotteryBtn.layer.shadowOffset = CGSizeMake(5, 5);
    //lotteryBtn.layer.shadowColor = [UIColor greenColor].CGColor;
    //lotteryBtn.layer.shadowOpacity = YES;
}

-(void)lotteryBtnUnSelected:(UIButton *)lotteryBtn{
    //lotteryBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    lotteryBtn.layer.borderWidth = 0.1;
    //lotteryBtn.layer.shadowOffset = CGSizeMake(lotteryBtn.bounds.size.width, lotteryBtn.bounds.size.height);
    //lotteryBtn.layer.shadowColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

-(NSArray *)info{
    if (!_info) {
        _info = @[@"2E币",@"5E币",@"8E币",@"12E币",@"5元红包",@"谢谢参与",@"0.08元",@"2元",@"3E币",@"2E币",@"188元",@"7E币"];
    }
    return _info;
}

-(NSArray *)lotterybtns{
    if (!_lotterybtns) {
        _lotterybtns = @[_lotteryBtn1,_lotteryBtn2,_lotteryBtn3,_lotteryBtn4,_lotteryBtn5,_lotteryBtn6,_lotteryBtn7,_lotteryBtn8,_lotteryBtn9,_lotteryBtn10,_lotteryBtn11,_lotteryBtn12];
    }
    return _lotterybtns;
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
