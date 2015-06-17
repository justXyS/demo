//
//  MallViewController.m
//  E小区
//
//  Created by apple on 15/1/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//



#import "MallViewController.h"
#import "MenuTableView.h"
#import "MyOrderCell.h"
#import "MallModel.h"
#import "BuyTableView.h"
#import "BuyService.h"
#import "Sub_Good_typeModel.h"
#import "MJRefresh.h"
#import "MallDetailViewController.h"
#import "PanButton.h"

@interface MallViewController ()<UIGestureRecognizerDelegate,MenuTableViewDelegate>
@property (weak, nonatomic) IBOutlet MenuTableView *menuTableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *goods;
@property (nonatomic,assign) BOOL showing;
@property (nonatomic,strong) BuyService *service;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,copy) NSString *subid;
@property (nonatomic,assign) BOOL noMore;  //没有更多
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnY;
@property (weak, nonatomic) IBOutlet PanButton *cart;
@end

@implementation MallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self.tableView addHeaderWithCallback:^{
        [self refresh];
    }];
    [self.tableView addFooterWithCallback:^{
        [self pull];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.menuTableView.menus = self.subtypes;
    self.menuTableView.menuDelegate = self;
    [self.menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.tableView headerBeginRefreshing];
    CGPoint center = [self.cart resetLocation];
    if (!(center.x == 0 && center.y ==0)) {
        self.btnX.constant = center.x - self.cart.bounds.size.width/2 - 16;
        self.btnY.constant = center.y - 64 - self.cart.bounds.size.height/2;
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]){
        UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)gestureRecognizer;
        if(UISwipeGestureRecognizerDirectionLeft==swipe.direction||UISwipeGestureRecognizerDirectionRight==swipe.direction){
            return YES;
        }
    }
    return NO;
}

#pragma mark 浮动的购物车
- (IBAction)pan:(PanButton *)sender {
    
}

-(IBAction)showMenu:(UISwipeGestureRecognizer *)gestureRecognizer{
    CGPoint center = self.tableView.center;
    if(!self.showing){
        center.x +=120;
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.center = center;
        } completion:^(BOOL finished) {
            self.showing = YES;
        }];
    }
}

-(IBAction)closeMenu:(UISwipeGestureRecognizer *)gestureRecognizer{
    [self close];
}

-(void)close{
    CGPoint center = self.tableView.center;
    if(self.showing){
        center.x -= 120;
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.center = center;
        } completion:^(BOOL finished) {
            self.showing = NO;
        }];
    }
}

#pragma mark - tableView 委托
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goods.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mall_cell" forIndexPath:indexPath];
    MallModel *model = self.goods[indexPath.row];
    cell.good_name.text = model.name;
    cell.good_price.text = [NSString stringWithFormat:@"原价:%@",model.price];
    CGFloat zhekou = (CGFloat)[model.discount intValue]/(CGFloat)[model.price intValue];
    cell.status.text = [NSString stringWithFormat:@"%.1f折",zhekou*10];
    cell.time.text = [NSString stringWithFormat:@"会员价:%@",model.discount];
    [cell.order_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,model.picture]] placeholderImage:[UIImage imageNamed:@"e"] completed:nil];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)refresh{
    self.page = 1;
    [self.service getGoodsBySubId:self.subid page:self.page complementHandler:^(NSArray *goods) {
        if (!goods ||goods.count<10) {
            self.noMore = YES;
        }
        self.goods = goods;
        [self.tableView headerEndRefreshing];
    } errorHandler:^(id info) {
        [self.tableView headerEndRefreshing];
    }];
}

-(void)pull{
    if (!self.noMore) {
        [self.service getGoodsBySubId:self.subid page:++self.page complementHandler:^(NSArray *goods) {
            if (!goods ||goods.count<10) {
                self.noMore = YES;
            }
            NSMutableArray *gs = [self.goods mutableCopy];
            [gs addObjectsFromArray:goods];
            self.goods = [gs copy];
            [self.tableView footerEndRefreshing];
        } errorHandler:^(id info) {
            [self.tableView footerEndRefreshing];
        }];
    }else{
        self.page--;
        [SVProgressHUD showErrorWithStatus:@"没有更多了"];
        [self.tableView footerEndRefreshing];
    }
}

-(BuyService *)service{
    if (!_service) {
        _service = [[BuyService alloc] init];
    }
    return _service;
}

-(void)setGoods:(NSArray *)goods{
    _goods = goods;
    [self.tableView reloadData];
}

-(void)menuTableView:(MenuTableView *)menu didSelected:(NSIndexPath *)indexPath{
    [self close];
    self.noMore = NO;
    Sub_Good_typeModel *model = self.subtypes[indexPath.row];
    if (self.subid && [self.subid isEqualToString:model.subid]) {
        
    }else{
        self.subid = model.subid;
        [self.tableView headerBeginRefreshing];
    }
}

-(NSString *)subid{
    if (!_subid) {
        Sub_Good_typeModel *model = self.subtypes[0];
        if(model){
            _subid = model.subid;
        }
    }
    return _subid;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}


 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([sender isKindOfClass:[MyOrderCell class]]) {
         MyOrderCell *cell = sender;
         if ([segue.destinationViewController isKindOfClass:[MallDetailViewController class]]) {
             MallDetailViewController *mdvcr = segue.destinationViewController;
             NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
             MallModel *model = self.goods[indexPath.row];
             mdvcr.gid = model.gid;
         }
     }
 }


@end
