//
//  KillViewController.m
//  E小区
//
//  Created by apple on 15/1/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "KillViewController.h"
#import "MyOrderCell.h"
#import "KillGoodModel.h"
#import "KillService.h"

@interface KillViewController ()
@property (nonatomic,strong) NSArray *killGoods;
@property (nonatomic,strong) KillService *service;
@end

@implementation KillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.killGoods) {
        [self.service killList:^(NSArray *killgoods) {
            self.killGoods = killgoods;
            [self.tableView reloadData];
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.killGoods.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 22)];
    //view.backgroundColor = [UIColor redColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
    imageView.image = [UIImage imageNamed:@"future_kill_bg"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [view addSubview:imageView];
    UILabel *lable = [[UILabel alloc] initWithFrame:view.frame];
    lable.contentMode = UIViewContentModeCenter;
    lable.textColor = [UIColor whiteColor];
    lable.text = @"12:00";
    [view addSubview:lable];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kill_cell" forIndexPath:indexPath];
    KillGoodModel *kill = self.killGoods[indexPath.section];
    [cell.order_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,kill.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
    cell.good_price.text = @"ccc";
    cell.good_name.text = kill.name;
    cell.time.text = @"2012-02-03";
    cell.status.text = @"";
    return cell;
}

-(KillService *)service{
    if (!_service) {
        _service = [[KillService alloc] init];
    }
    return _service;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
