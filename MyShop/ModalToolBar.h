//
//  ModalToolBar.h
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalToolBarDelegate<NSObject>

-(void)clickBack;

@end

@interface ModalToolBar : UIToolbar

@property (nonatomic,assign) id<ModalToolBarDelegate> modalDelegate;

@end
