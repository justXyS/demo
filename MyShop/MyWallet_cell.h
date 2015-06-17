//
//  MyWallet_cell.h
//  E小区
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyWalletDelegate <NSObject>

-(void)clickCell:(UITableViewCell *)cell button:(UIButton *)btn;

@end

@interface MyWallet_cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (nonatomic,strong) id<MyWalletDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *button;


@end
