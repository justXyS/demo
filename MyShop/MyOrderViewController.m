//
//  MyOrderViewController.m
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyOrderViewController.h"
#import "BuyOrderModel.h"
#import "MyOrderCell.h"
#import "OthersModel.h"
#import "OrderService.h"
#import "MJRefresh.h"

@interface MyOrderViewController ()
@property (nonatomic,strong) NSMutableArray *otherOrders;
@property (nonatomic,assign) NSInteger currPage;
@property (nonatomic,strong) NSArray *buyOrders;
@property (nonatomic,assign) BOOL buyOrderNoMore;
@property (nonatomic,assign) NSInteger buyOrderPage;
@property (nonatomic,strong) OrderService *service;
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buyOrderPage = 1;
    __weak MyOrderViewController *weak = self;
    [self.tableView addFooterWithCallback:^{
        [weak pull];
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.service orderListByPage:[NSString stringWithFormat:@"%lu",self.buyOrderPage++] complementHandler:^(NSArray *orders) {
        if (orders.count<10) {
            self.buyOrderNoMore = YES;
        }
        self.buyOrders = orders;
        [self.tableView reloadData];
    } errorHandler:^{
        self.buyOrderPage--;
    }];
    self.otherOrders = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        OthersModel *order1 = [[OthersModel alloc] init];
        order1.order_id = 1;
        order1.order_name = @"白痴";
        order1.status = @"已支付";
        order1.time = @"1992-02-02";
        order1.image_url = @"e";
        order1.price = @"会员价:免费";
        [self.otherOrders addObject:order1];
    }
}

- (IBAction)chooseOrderType:(UISegmentedControl *)sender {
     self.currPage = sender.selectedSegmentIndex;
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.buyOrders.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.currPage==0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myOrder" forIndexPath:indexPath];
        BuyOrderModel *order = self.buyOrders[indexPath.row];
        cell.textLabel.text = order.demo;
        cell.detailTextLabel.text = order.status;
        return cell;
    }else{
        MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myOrder_others" forIndexPath:indexPath];
        OthersModel *other = self.otherOrders[indexPath.row];
        cell.good_name.text = other.order_name;
        cell.good_price.text = other.price;
        cell.status.text = other.status;
        cell.time.text = other.time;
        cell.order_image.image = [UIImage imageNamed:other.image_url];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.currPage==0?44:100;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currPage==0) {
        return YES;
    }
    return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        BuyOrderModel *model = self.buyOrders[indexPath.row];
        [self.service returnOrderByOrderid:model.orderid complementHandler:^{
            NSMutableArray *array = [self.buyOrders mutableCopy];
            [array removeObjectAtIndex:indexPath.row];
            self.buyOrders = array;
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }]; 
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"退货";
}

-(void)pull{
    switch (self.currPage) {
        case 0:
            if (!self.buyOrderNoMore) {
                [self.service orderListByPage:[NSString stringWithFormat:@"%lu",self.buyOrderPage++] complementHandler:^(NSArray *orders) {
                    if (orders.count<10) {
                        self.buyOrderNoMore = YES;
                    }
                    NSMutableArray *buyOrders = [NSMutableArray arrayWithArray:self.buyOrders];
                    [buyOrders addObjectsFromArray:orders];
                    self.buyOrders = buyOrders;
                    [self.tableView footerEndRefreshing];
                } errorHandler:^{
                    self.buyOrderPage --;
                    [self.tableView footerEndRefreshing];
                }];
            }
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

-(OrderService *)service{
    if (!_service) {
        _service = [[OrderService alloc] init];
    }
    return _service;
}


@end
