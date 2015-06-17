//
//  ViewStyle.h
//  E小区
//
//  Created by apple on 15/1/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewStyle : NSObject

+(UIButton *)addRadius:(UIButton *)btn;

+(NSAttributedString *)addAttributeWithString:(NSString *)string rang:(NSRange)rang color:(UIColor *)color;

@end

@interface UIButton(Style)

//-(UIButton *)addRadius:(UIButton *)btn;

@end
