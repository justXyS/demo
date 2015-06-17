//
//  MyWallet_cell.m
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyWallet_cell.h"

@implementation MyWallet_cell

-(UILabel *)titleLable{
    _button.layer.cornerRadius = 5;
    return _titleLable;
}
- (IBAction)btnClick:(UIButton *)sender {
    if([self.superview.superview isKindOfClass:[UITableView class]]){
        //UITableView *tableView = self.superview.superview;
        // NSLog(@"%@",[tableView indexPathForCell:self]);
        [self.delegate clickCell:self button:self.button];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
