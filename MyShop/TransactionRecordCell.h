//
//  TransactionRecordCell.h
//  E小区
//
//  Created by apple on 15/1/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@end
