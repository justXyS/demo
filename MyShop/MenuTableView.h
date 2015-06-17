//
//  MenuTableView.h
//  E小区
//
//  Created by apple on 15/1/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuTableView;

@protocol MenuTableViewDelegate <NSObject>

-(void)menuTableView:(MenuTableView *)menu didSelected:(NSIndexPath *)indexPath;

@end

@interface MenuTableView : UITableView
@property (nonatomic,strong)NSArray *menus;
@property (nonatomic,strong) id<MenuTableViewDelegate> menuDelegate;
@end
