//
//  MainColorBoardButton.m
//  E小区
//
//  Created by apple on 15/2/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MainColorBoardButton.h"

@implementation MainColorBoardButton

-(void)awakeFromNib{
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 2;
    self.layer.borderColor = MAIN_COLOR.CGColor;
}

@end
