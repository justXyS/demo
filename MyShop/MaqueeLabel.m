//
//  MaqueeLabel.m
//  E小区
//
//  Created by apple on 15/2/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MaqueeLabel.h"

@interface MaqueeLabel()
@property (nonatomic,assign) CGFloat maxWidth;
@end

@implementation MaqueeLabel

-(void)setText:(NSString *)text maquee:(BOOL)maquee{
    self.text = text;
    self.maquee = maquee;
    UIFont *font = self.font;
    CGRect oldframe = self.frame;
    CGRect frame = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, CGRectGetMaxY(oldframe)) options:NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:font} context:nil];
    self.maxWidth = CGRectGetMaxX(frame);
    self.frame = frame;
    if (self.maquee) {
        [self changeFrame];
    }
}

-(void)changeFrame{
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(temp) userInfo:nil repeats:NO];
}

-(void)temp{
    if (self.maxWidth < K_SCREEN_BOUNDS_SIZE.width) return;
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(gogo:) userInfo:nil repeats:YES];
}

-(void)gogo:(NSTimer *)timer{
    CGRect frame = self.frame;
    if (fabsf(frame.origin.x - K_SCREEN_BOUNDS_SIZE.width +50) >= self.maxWidth) {
        frame.origin.x = 0;
    }else{
        frame.origin.x -= 2;
    }
    self.frame = frame;
}

@end
