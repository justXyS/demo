//
//  ExchangeViewController.m
//  E小区
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ExchangeViewController.h"
#import "ExchangeCell.h"
#import "ExchangeService.h"
#import "MJRefresh.h"
#import "ExchangeDetailViewController.h"

@interface ExchangeViewController ()
@property (nonatomic,strong) NSArray *goods;
@property (nonatomic,strong) ExchangeService *service;
@property (nonatomic,assign) BOOL hasNoMore;
@property (nonatomic,assign) NSInteger page;
@end

@implementation ExchangeViewController

static NSString * const reuseIdentifier = @"exchangeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[ExchangeDetailViewController class]] && [@"to exchangeDetail" isEqualToString:segue.identifier] && [sender isKindOfClass:[ExchangeCell class]]) {
        ExchangeDetailViewController *edvctr = segue.destinationViewController;
        ExchangeCell *cell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        edvctr.exchangeModel = self.goods[indexPath.row];
        edvctr.title = edvctr.exchangeModel.name;
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.goods) {
        [self.service exchangeListWithPage:[NSString stringWithFormat:@"%lu",self.page] complementHandler:^(NSArray *goods) {
            self.goods = goods;
            self.page++;
            if (goods.count<10) {
                self.hasNoMore = YES;
            }else{
                __weak ExchangeViewController *weakSelf = self;
                [self.collectionView addFooterWithCallback:^{
                    [weakSelf pull];
                }];
            }
            [self.collectionView reloadData];
        } errorHandler:nil];
    }
}

-(void)pull{
    if (!self.hasNoMore) {
        [self.service exchangeListWithPage:[NSString stringWithFormat:@"%lu",self.page] complementHandler:^(NSArray *goods) {
            [self.collectionView footerEndRefreshing];
            NSMutableArray *models = [NSMutableArray arrayWithArray:self.goods];
            [models addObjectsFromArray:goods];
            self.page++;
            if (goods.count<10) {
                self.hasNoMore = YES;
                [self.collectionView removeFooter];
                [self.collectionView reloadData];
            }
        } errorHandler:^(NSDictionary *json){
            [self.collectionView footerEndRefreshing];
            int status = [[json objectForKey:@"status"] intValue];
            if (808 == status) {
                [self.collectionView removeFooter];
            }
        }];
    }
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExchangeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.exchangeModel = self.goods[indexPath.row];
    return cell;
}

-(ExchangeService *)service{
    if (!_service) {
        _service = [[ExchangeService alloc] init];
    }
    return _service;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
