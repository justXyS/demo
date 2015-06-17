//
//  MyWalletViewController.m
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyWalletViewController.h"
#import "Index0_cell_1.h"
#import "MyWallet_cell.h"
#import "Balance.h"
#import "BalanceService.h"

@interface MyWalletViewController ()<MyWalletDelegate>
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *btnTitles;
@property (nonatomic,strong) Balance *balance;
@property (nonatomic,strong) BalanceService *service;
@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnTitles = @[@"充值",@"交易记录",@"E币记录"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.balance) {
        [self.service balance:^(Balance *balance) {
            self.balance = balance;
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.titles.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0){
        Index0_cell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"wallet_cell_1" forIndexPath:indexPath];
        [cell setImageNames:[NSMutableArray arrayWithArray:@[@"mycard_front",@"mycard_contrary"]] AndTimer:0 isAuto:NO placeholderImage:nil animationType:@"flip" notNeedPageIcon:YES];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        MyWallet_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"wallet_cell_2" forIndexPath:indexPath];
        cell.delegate = self;
        cell.titleLable.text = self.titles[indexPath.row-1];
        [cell.button setTitle:self.btnTitles[indexPath.row-1] forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row==0?150:44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

#pragma mark -tableview button click delegate
-(void)clickCell:(UITableViewCell *)cell button:(UIButton *)btn{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *ctr;
    if(indexPath.row==1){//充值
        
    }else if(indexPath.row==2){//交易记录
        ctr = [storyboard instantiateViewControllerWithIdentifier:@"transactionRecord"];
    }else if(indexPath.row==3){//E币记录
        ctr = [storyboard instantiateViewControllerWithIdentifier:@"ebDetail"];
    }
    [self.navigationController pushViewController:ctr animated:YES];
}

-(void)setBalance:(Balance *)balance{
    if (balance) {
        _balance = balance;
        self.titles = @[[NSString stringWithFormat:@"钱包余额:￥%@",_balance.amount],[NSString stringWithFormat:@"红包余额:￥%@",_balance.amount_red],[NSString stringWithFormat:@"E币余额:%@枚",_balance.point]];
        [self.tableView reloadData];
    }
}

-(BalanceService *)service{
    if (!_service) {
        _service = [[BalanceService alloc] init];
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
