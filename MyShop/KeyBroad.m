//
//  KeyBroad.m
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#define KMARGIN 2
#define K_BUTTON_WIDTH (K_SCREEN_BOUNDS_SIZE.width-4*KMARGIN)/3
#define K_BUTTON_HEIGHT self.frame.size.height/5

#import "KeyBroad.h"

@implementation KeyBroad

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUp];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setUp{
    for(int i=0;i<3;i++){
        for(int j=0;j<4;j++){
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KMARGIN+(K_BUTTON_WIDTH+KMARGIN)*i, KMARGIN+(KMARGIN+K_BUTTON_HEIGHT)*j, K_BUTTON_WIDTH, K_BUTTON_HEIGHT)];
            btn.titleLabel.text = [NSString stringWithFormat:@"%d",i+i*j];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            btn.backgroundColor = [UIColor redColor];
            [self addSubview:btn];
        }
    }
}

@end
