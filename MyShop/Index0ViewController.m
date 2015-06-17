//
//  Index0ViewController.m
//  E小区
//
//  Created by apple on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Index0ViewController.h"
#import "Index0_cell_1.h"
#import "Index0_cell_2.h"
#import "Index0_collection.h"
#import "Index0_cell_3.h"
#import "UIImageView+WebCache.h"
#import "MallViewController.h"
#import "MallModel.h"
#import "KillViewController.h"
#import "BuyService.h"
#import "Good_typeModel.h"
#import "Sub_Good_typeModel.h"

@interface Index0ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)NSMutableArray *adImages;
@property (nonatomic,strong)NSArray *cell_2_titles;
@property (nonatomic,strong)NSArray *cell_2_images;
@property (nonatomic,strong)NSArray *goods_types;;
@property (nonatomic,strong)BuyService *service;
@end

@implementation Index0ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showWithStatus:@"加载中.."];
    _adImages = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%@%@",IP,[[NSUserDefaults standardUserDefaults] objectForKey:@"picture_1_0"]],[NSString stringWithFormat:@"%@%@",IP,[[NSUserDefaults standardUserDefaults] objectForKey:@"picture_1_1"]],[NSString stringWithFormat:@"%@%@",IP,[[NSUserDefaults standardUserDefaults] objectForKey:@"picture_1_2"]],[NSString stringWithFormat:@"%@%@",IP,[[NSUserDefaults standardUserDefaults] objectForKey:@"picture_1_3"]]]];
}

-(NSArray *)cell_2_images{
    if(!_cell_2_images){
        _cell_2_images = @[@"rob.jpg",@"seckill.jpg",@"team_buy.jpg",@"buy.jpg",@"recharge.jpg",@"lotterydraw.jpg",@"exchange.jpg",@"wallet.jpg"];
    }
    return _cell_2_images;
}

-(NSArray *)cell_2_titles{
    if(!_cell_2_titles){
        _cell_2_titles = @[@"抢菜",@"秒杀",@"团购",@"购物车",@"充值",@"抽奖",@"兑换",@"钱包"];
    }
    return _cell_2_titles;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!self.goods_types){
        [self.service getGoodType:^(NSArray *types){
            self.goods_types = types;
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2+self.goods_types.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if(row==0){
        Index0_cell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"index0_1" forIndexPath:indexPath];
        [cell setUrls:_adImages AndTimer:4 isAuto:YES placeholderImage:nil animationType:nil];
        return cell;
    }else if(row == 1){
        Index0_cell_2 *cell = [tableView dequeueReusableCellWithIdentifier:@"index0_2" forIndexPath:indexPath];
        cell.conllectionView.bounces = NO;
        return cell;
    }else{
        Index0_cell_3 *cell = [tableView dequeueReusableCellWithIdentifier:@"index0_3" forIndexPath:indexPath];
        Good_typeModel *type = self.goods_types[row-2];
        cell.titleLable.text = type.name;
        NSMutableString *subtitle = [NSMutableString string];
        NSArray *array = type.subtype;
        if (array && array.count>0) {
            for (int i=0; i<array.count; i++) {
                Sub_Good_typeModel *model = array[i];
                [subtitle appendFormat:@"/%@",model.name];
                NSString *sub = [subtitle substringFromIndex:1];
                cell.subLable.text = sub;
            }
        }
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IP,type.picture]] placeholderImage:[UIImage imageNamed:@"e"]];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 100;
            break;
        case 1:
            return 200;
        default:
            return 100;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - collection delegate

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Index0_collection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"index0_collection" forIndexPath:indexPath];
    cell.title.text = self.cell_2_titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.cell_2_images[indexPath.row]];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *ctr = nil;
    switch (indexPath.row) {
        case 1:
            ctr = [storyboard instantiateViewControllerWithIdentifier:@"kill"];
            break;
        case 2:
            ctr = [storyboard instantiateViewControllerWithIdentifier:@"groupBuyViewController"];
            break;
        case 3:
            ctr = [storyboard instantiateViewControllerWithIdentifier:@"cartViewController"];
            break;
        case 4:
            ctr = [storyboard instantiateViewControllerWithIdentifier:@"rechargeViewController"];
            break;
        case 5:
            ctr = [storyboard instantiateViewControllerWithIdentifier:@"lotteryViewController"];
            break;
        case 6:
            ctr = [storyboard instantiateViewControllerWithIdentifier:@"exchangeViewController"];
            break;
        case 7:
            ctr = [storyboard instantiateViewControllerWithIdentifier:@"myWalletViewController"];
        default:
            break;
    }
    [self.navigationController pushViewController:ctr animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([sender isKindOfClass:[Index0_cell_3 class]]){
        NSIndexPath *indexpath = [self.tableView indexPathForCell:sender];
        if([segue.destinationViewController isKindOfClass:[MallViewController class]]){
            MallViewController *mall = segue.destinationViewController;
            Good_typeModel *model = self.goods_types[indexpath.row-2];
            mall.subtypes = model.subtype;
        }
    }
}

-(void)setGoods_types:(NSArray *)goods_types{
    _goods_types = goods_types;
    [self.tableView reloadData];
}

-(BuyService *)service{
    if(!_service){
        _service = [[BuyService alloc] init];
    }
    return _service;
}

@end
