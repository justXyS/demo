//
//  AlertTool.m
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AlertTool.h"
static UIAlertView *alert;
@interface AlertTool()

@end
static UIAlertView *alert;
@implementation AlertTool

+(void)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancel otherButtonTitles:(NSString *)others,...{
    alert.title = @"title";
    alert.message = message;
    alert.delegate = delegate;
}


+(UIAlertView *)alert{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        alert = [[UIAlertView alloc] init];
    });
    return alert;
}

@end
