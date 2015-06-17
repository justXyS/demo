//
//  CartGood.h
//  E小区
//
//  Created by apple on 15/2/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface CartGood : BaseModel
@property (nonatomic,copy)NSString *gid;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *picture;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *discount;
@property (nonatomic,copy)NSString *unit;
@property (nonatomic,copy)NSString *num;
@property (nonatomic,copy)NSString *total;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *unit_num;
@end
