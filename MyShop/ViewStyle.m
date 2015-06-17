//
//  ViewStyle.m
//  E小区
//
//  Created by apple on 15/1/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewStyle.h"

@implementation ViewStyle

+(UIButton *)addRadius:(UIButton *)btn{
    UIButton *button = btn;
    button.layer.cornerRadius = 5;
    //button.layer.shadowColor = [UIColor redColor].CGColor;
    return btn;
}

+(NSAttributedString *)addAttributeWithString:(NSString *)string rang:(NSRange)rang color:(UIColor *)color{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:color} range:rang];
    return attributeString;
}

@end

@implementation UIButton(Style)



@end