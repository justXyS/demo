//
//  MaqueeLabel.h
//  E小区
//
//  Created by apple on 15/2/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaqueeLabel : UILabel
@property (nonatomic,assign) BOOL maquee;

-(void)setText:(NSString *)text maquee:(BOOL)maquee;
@end
