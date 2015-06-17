//
//  RechargeCell.m
//  E小区
//
//  Created by apple on 15/2/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//



#import "RechargeCell.h"

@interface RechargeCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@end

@implementation RechargeCell


-(void)setRechargeModel:(RechargeModel *)rechargeModel{
    _rechargeModel = rechargeModel;
    self.image.image = [UIImage imageNamed:_rechargeModel.path];
    self.name.text = _rechargeModel.payName;
    self.promptLabel.text = rechargeModel.payPrompt;
    self.isCheck = NO;
    [self.checkButton setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
}

- (IBAction)check:(id)sender {
//    if (self.isCheck) {
//        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
//    }else{
//        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
//    }
//    self.isCheck = !self.isCheck;
}

-(void)setIsCheck:(BOOL)isCheck{
    _isCheck = isCheck;
    if (!_isCheck) {
        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"checked_false"] forState:UIControlStateNormal];
    }else{
        [self.checkButton setBackgroundImage:[UIImage imageNamed:@"checked_true"] forState:UIControlStateNormal];
    }
    if (self.action) {
        self.action();
    }
}

@end
