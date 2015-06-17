//
//  MyOrderCell.h
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyOrderCellDelegate <NSObject>



@end

@interface MyOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *order_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
