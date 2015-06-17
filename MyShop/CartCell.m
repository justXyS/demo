//
//  CartCell.m
//  E小区
//
//  Created by apple on 15/2/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CartCell.h"

@interface CartCell()<UIAlertViewDelegate>

@end

@implementation CartCell

- (IBAction)jian:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jianCell:btn:)]) {
        [self.delegate jianCell:self btn:sender];
    }
}

- (IBAction)delete:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    alert.delegate = self;
    [alert show];
}

- (IBAction)check:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkCell:btn:)]) {
        [self.delegate checkCell:self btn:sender];
    }
}
- (IBAction)jia:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jiaCell:btn:)]) {
        [self.delegate jiaCell:self btn:sender];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteCell:)]) {
            [self.delegate deleteCell:self];
        }
    }
}


@end
