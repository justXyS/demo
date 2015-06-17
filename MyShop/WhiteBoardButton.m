//
//  WhiteBoardButton.m
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WhiteBoardButton.h"

@implementation WhiteBoardButton

-(void)awakeFromNib{
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
