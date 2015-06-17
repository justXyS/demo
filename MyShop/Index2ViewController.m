//
//  Index2ViewController.m
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Index2ViewController.h"
#import "Index2_cell.h"

@interface Index2ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSMutableArray * titles;
@end

@implementation Index2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.images = [NSMutableArray arrayWithArray:@[@"buy.jpg",@"rob.jpg",@"team_buy.jpg",@"buy.jpg",@"buy.jpg"]];
    self.titles = [NSMutableArray arrayWithArray:@[@"生活圈",@"我的邻居",@"二手信息",@"快递查询",@"水电缴费"]];
}

#pragma mark - tableview的委托和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row;
    if(section==0){
        row = 2;
    }else if(section==1){
        row = 3;
    }else{
        row = 1;
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Index2_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Index2_cell" forIndexPath:indexPath];
    NSInteger index = indexPath.row + indexPath.section*2;
    cell.imageTitle.image = [UIImage imageNamed:self.images[index]];
    cell.titleLable.text = self.titles[index];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *ctr;
    switch (indexPath.row) {
        case 0:
            ctr = [storyboard instantiateViewControllerWithIdentifier:@"circle"];
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:ctr animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
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
