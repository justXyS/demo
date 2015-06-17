//
//  PanButton.m
//  E小区
//
//  Created by apple on 15/2/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PanButton.h"

@interface PanButton()
@property (nonatomic,strong) UIPanGestureRecognizer *pan;
@end

@implementation PanButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)awakeFromNib{
    [self setUp];
}

-(void)setUp{
    self.layer.cornerRadius = 5;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
}

-(void)pan:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer translationInView:self];
    CGPoint center = self.center;
    center.x += point.x;
    center.y += point.y;
    CGRect bounds = self.bounds;
    if (center.x>bounds.size.width/2 && center.x< (K_SCREEN_BOUNDS_SIZE.width-bounds.size.width/2) && center.y<K_SCREEN_BOUNDS_SIZE.height-bounds.size.height/2 && center.y>20+44+bounds.size.height/2) {
        self.center = center;
        [[NSUserDefaults standardUserDefaults] setObject:NSStringFromCGPoint(center) forKey:@"center"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [gestureRecognizer setTranslation:CGPointZero inView:self];
}

-(CGPoint)resetLocation{
    NSString *center = [[NSUserDefaults standardUserDefaults] objectForKey:@"center"];
    if (center) {
        return CGPointFromString(center);
    }
    return CGPointZero;
}

-(void)removePan:(UIPanGestureRecognizer *)pan{
    if (self.pan) {
        [self removeGestureRecognizer:self.pan];
    }
}


@end
