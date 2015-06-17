//
//  CirclrLifeCell.h
//  E小区
//
//  Created by apple on 15/1/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleLifeModel;

@interface CirclrLifeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *head_path;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *btn_pl;
@property (weak, nonatomic) IBOutlet UIView *pl_view;
@property (nonatomic,strong) CircleLifeModel *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *plHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;

@end
