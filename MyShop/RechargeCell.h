//
//  RechargeCell.h
//  E小区
//
//  Created by apple on 15/2/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechargeModel.h"
@class RechargeCell;
typedef void(^Checked)();

@interface RechargeCell : UITableViewCell
@property (nonatomic,strong) RechargeModel *rechargeModel;
@property (assign,nonatomic) BOOL isCheck;
@property (strong,nonatomic) Checked action;
@end
