//
//  PanButton.h
//  E小区
//
//  Created by apple on 15/2/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanButton : UIButton

-(void)removePan:(UIPanGestureRecognizer *)pan;

-(CGPoint)resetLocation;

@end
