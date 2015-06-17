//
//  Index0_cell_1.h
//  E小区
//
//  Created by apple on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

enum Index0_cell_1_ImageType{
    URL,ImageName
};

@interface Index0_cell_1 : UITableViewCell

@property(nonatomic,assign) BOOL isAutoScroll;
@property(nonatomic,assign) NSTimeInterval timeInterval;
@property(nonatomic,strong) UIImage *placeholderImage;

-(void)setUrls:(NSMutableArray *)urls AndTimer:(NSTimeInterval)timeInterval isAuto:(BOOL)atou placeholderImage:(UIImage *)placeholderImage animationType:(NSString *)animationType;

-(void)setImageNames:(NSMutableArray *)imageNames AndTimer:(NSTimeInterval)timeInterval isAuto:(BOOL)atou placeholderImage:(UIImage *)placeholderImage animationType:(NSString *)animationType notNeedPageIcon:(BOOL)needPageIcon;
@end
