//
//  CircleLifeModel.h
//  E小区
//
//  Created by apple on 15/1/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleLifeModel : NSObject
@property (nonatomic,copy) NSString *xid;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *mid;
@property (nonatomic,copy) NSString *headpic;
@property (nonatomic,strong) NSMutableArray *comments;
@property (nonatomic,strong) NSMutableArray *pictures;
@end
