//
//  MenuTableView.m
//  E小区
//
//  Created by apple on 15/1/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MenuTableView.h"
#import "Sub_Good_typeModel.h"

@interface MenuTableView()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation MenuTableView

@synthesize menus = _menus;

-(void)awakeFromNib{
    self.dataSource = self;
    self.delegate = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menus.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu_cell" forIndexPath:indexPath];
    Sub_Good_typeModel *model = self.menus[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.menuDelegate && [self.menuDelegate respondsToSelector:@selector(menuTableView:didSelected:)]){
        [self.menuDelegate menuTableView:self didSelected:indexPath];
    }
}

-(void)setMenus:(NSArray *)menus{
    _menus = menus;
    [self reloadData];
}

@end
