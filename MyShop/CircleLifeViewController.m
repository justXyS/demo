//
//  CircleLifeViewController.m
//  E小区
//
//  Created by apple on 15/1/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CircleLifeViewController.h"
#import "CirclrLifeCell.h"
#import "Index0_cell_1.h"
#import "CircleLifeModel.h"
#import "Comment.h"

@interface CircleLifeViewController ()
@property (nonatomic,strong) NSMutableArray *cellHeights;
@property (nonatomic,strong) NSMutableArray *models;
@end

@implementation CircleLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSMutableArray *array = [NSMutableArray array];
    for (int i=1; i<20; i++) {
        NSMutableDictionary *dir = [NSMutableDictionary dictionary];
        CircleLifeModel *model = [[CircleLifeModel alloc] init];
        model.nickname = @"何以箫声默";
        model.headpic = @"exchange.jpg";
        if(i%3==0){
            model.content = @"何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声";
        }else{
            model.content = @"何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默何以箫声默";
        }
        if(i%2==0){
            model.pictures = [[NSMutableArray alloc] initWithArray:@[@"mycard_front",@"mycard_front"]];
        }
        if(i%4==0){
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:@[]];
            for(int i=0;i<4;i++){
                Comment *c = [[Comment alloc] init];
                c.nickname = @"何以箫声默";
                c.content = @"声默何以箫声默何以何以箫声默何以箫声默何以箫声默何";
                [array addObject:c];
            }
            model.comments = array;
        }
        model.time = @"10小时前";
        CGFloat contentHeight = [model.content boundingRectWithSize:CGSizeMake(K_SCREEN_BOUNDS_SIZE.width-47, MAXFLOAT) options:
                                 NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
        NSNumber *content = [NSNumber numberWithFloat:contentHeight];
        [dir setObject:content forKey:@"contentHeight"];
        CGFloat pic = 0;
        if(model.pictures && [model.pictures firstObject]){
            pic = 60;
            NSNumber *picturesHieght = [NSNumber numberWithFloat:60];
            [dir setObject:picturesHieght forKey:@"picturesHieght"];
        }else{
            NSNumber *picturesHieght = [NSNumber numberWithFloat:0];
            [dir setObject:picturesHieght forKey:@"picturesHieght"];
        }
        CGFloat commentHeightTotal = 0;
        if(model.comments && [model.comments firstObject]){
            for (int i = 0; i<model.comments.count; i++) {
                Comment *comment = model.comments[i];
                NSString *string = [NSString stringWithFormat:@"%@:%@",comment.nickname,comment.content];
                NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:string];
                [content addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:133/256 green:99/256 blue:223/256 alpha:1]
                                range:[string rangeOfString:[NSString stringWithFormat:@"%@:",comment.nickname]]];
                CGFloat commentHeight = [string boundingRectWithSize:CGSizeMake(K_SCREEN_BOUNDS_SIZE.width-47, MAXFLOAT) options:
                                         NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
                commentHeightTotal += commentHeight;
            }
            [dir setObject:[NSNumber numberWithFloat:commentHeightTotal] forKey:@"commentHeight"];
        }
        NSNumber *rowHeight = [NSNumber numberWithFloat:200+contentHeight+(commentHeightTotal-80)+(pic-60)];
        //commentHeightTotal = 0;
        [dir setObject:rowHeight forKey:@"rowHeight"];
        [self.cellHeights addObject:dir];
        [array addObject:model];
    }
    self.models = array;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellHeights.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0){
        Index0_cell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"circlr_cell_1" forIndexPath:indexPath];
        //[cell setUrls:[NSMutableArray arrayWithArray:@[@"e"]] AndTimer:0 isAuto:YES placeholderImage:[UIImage imageNamed:@"e"] animationType:nil];
        [cell setImageNames:[NSMutableArray arrayWithArray:@[@"mycard_front"]] AndTimer:4 isAuto:NO placeholderImage:nil animationType:@"filp" notNeedPageIcon:YES];
        return cell;
    }else{
        NSDictionary *dir = self.cellHeights[indexPath.row-1];
        CirclrLifeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"circlr_cell_2" forIndexPath:indexPath];
        CircleLifeModel *model = self.models[indexPath.row-1];
        cell.model = model;
        NSNumber *collectionHeight = [dir objectForKey:@"picturesHieght"];
        NSNumber *plHeight = [dir objectForKey:@"commentHeight"];
        cell.collectionHeight.constant = collectionHeight.floatValue;
        cell.plHeight.constant = plHeight.floatValue;
        
        //[self.cellHeights addObject:[NSNumber numberWithFloat:(200+contentHeight-40)]];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    if(indexPath.row==0){
        height = 150;
    }else{
        if(self.cellHeights && self.cellHeights.count>=indexPath.row){
            NSDictionary *dir = self.cellHeights[indexPath.row-1];
            height = [[dir objectForKey:@"rowHeight"] floatValue];
        }
    }
    return height;
}

-(NSMutableArray *)cellHeights{
    if(!_cellHeights){
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
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
