
//
//  BaseViewController.m
//  E小区
//
//  Created by apple on 15/2/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIAlertViewDelegate>

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toLogin:) name:OUT_LINE_NOTIFACATION_NAME object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:OUT_LINE_NOTIFACATION_NAME object:nil];
}

-(void)toLogin:(NSNotification *)notification{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[[notification userInfo] objectForKey:@"error"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"去登陆", nil];
    alert.tag = 101;
    alert.delegate = self;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 101){
        UIViewController *vcr = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:vcr animated:NO completion:nil];
    }
}

@end
