//
//  Goods.h
//  E小区
//
//  Created by apple on 15/2/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseModel.h"

@interface Goods : BaseModel
@property (nonatomic,copy)NSString *gid;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *intro;
@property (nonatomic,copy)NSString *nums;
@property (nonatomic,copy)NSString *picture;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *bigpicture;
@property (nonatomic,copy)NSString *discount;
@property (nonatomic,copy)NSString *unit;
@property (nonatomic,copy)NSString *unit_num;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *goods_new;
@property (nonatomic,copy)NSString *logistics;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *share_url;
@end
