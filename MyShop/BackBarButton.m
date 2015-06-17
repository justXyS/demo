//
//  BackBarButton.m
//  E小区
//
//  Created by apple on 15/1/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BackBarButton.h"

@implementation BackBarButton

-(void)awakeFromNib{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 50, 50);
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"icon_left"];
    imageView.frame = CGRectMake(0, 15, 10, 20);
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 40, 50)];
    title.text =@"返回";
    [view addSubview:imageView];
    [view addSubview:title];
    self.customView = view;
}

@end
