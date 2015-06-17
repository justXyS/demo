//
//  CartCell.h
//  E小区
//
//  Created by apple on 15/2/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CartCell;
@protocol CartCellDelegate <NSObject>
@optional
- (void)jianCell:(CartCell *)cell btn:(UIButton *)sender  ;
- (void)deleteCell:(CartCell *)cell ;
- (void)checkCell:(CartCell *)cell btn:(UIButton *)sender ;
- (void)jiaCell:(CartCell *)cell btn:(UIButton *)sender ;
@end

@interface CartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhekou;
@property (nonatomic,assign) id<CartCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (nonatomic,assign) BOOL isCheck;
@property (nonatomic,assign) CGFloat totalPrice;
@end
