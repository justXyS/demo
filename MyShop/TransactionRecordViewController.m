//
//  TransactionRecordViewController.m
//  E小区
//
//  Created by apple on 15/1/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TransactionRecordViewController.h"
#import "TransactionRecordCell.h"
#import "TransactionRecordModel.h"
#import "TransactionService.h"
#import "MJRefresh.h"

@interface TransactionRecordViewController ()
@property (nonatomic,strong)NSArray *transactionRecords;
@property (nonatomic,strong)TransactionService *service;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) BOOL hasNoMore;
@end

@implementation TransactionRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.transactionRecords) {
        self.page = 1;
        [SVProgressHUD showWithStatus:@"加载中.."];
        [self.service transactionRecordWithPage:[NSString stringWithFormat:@"%lu",self.page] complement:^(NSArray *records) {
            self.transactionRecords = records;
            if (records.count<10) {
                self.hasNoMore = YES;
            }else{
                __weak TransactionRecordViewController *weakSelf = self;
                [self.tableView addFooterWithCallback:^{
                    [weakSelf pull];
                }];
            }
            self.page ++;
        } errorHandler:nil];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactionRecords.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transactionRecord_cell" forIndexPath:indexPath];
    TransactionRecordModel *model = self.transactionRecords[indexPath.row];
    cell.timeLable.text = model.regtime;
    cell.titleLable.text = model.demo;
    cell.contentLable.text = model.amount;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(TransactionService *)service{
    if (!_service) {
        _service = [[TransactionService alloc] init];
    }
    return _service;
}

-(void)pull{
    if (!self.hasNoMore) {
        [self.service transactionRecordWithPage:[NSString stringWithFormat:@"%lu",self.page] complement:^(NSArray *records) {
            [self.tableView footerEndRefreshing];
            NSMutableArray *recos = [NSMutableArray arrayWithArray:self.transactionRecords];
            [recos addObjectsFromArray:records];
            self.transactionRecords = recos;
            if (records.count<10) {
                self.hasNoMore = YES;
                [self.tableView removeFooter];
            }
            self.page ++;
        } errorHandler:^(NSDictionary *json) {
            int status = [[json objectForKey:@"status"] intValue];
            if (808 ==status) {
                [self.tableView removeFooter];
                self.hasNoMore = YES;
            }
        }];
    }
}

-(void)setTransactionRecords:(NSMutableArray *)transactionRecords{
    if (transactionRecords) {
        _transactionRecords = transactionRecords;
    }else{
        _transactionRecords = @[];
    }
    [self.tableView reloadData];
}

@end
